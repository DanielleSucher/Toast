//
//  DESLevenshtein.m
//  Toast
//
//  Created by Danielle Sucher on 3/2/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

#import "DESLevenshtein.h"

@implementation DESLevenshtein

@synthesize editGrid = _editGrid;
@synthesize editDistance = _editDistance;

// designated initializer
- (id)initWithStringOne:(NSString *)stringOne andStringTwo:(NSString *)stringTwo {
    self = [super init];
    if (self) {
        _stringOne = stringOne;
        _stringTwo = stringTwo;
    }
    return self;
}

- (NSMutableArray *)editGrid {
    if (!_editGrid) {
        _editGrid = [NSMutableArray arrayWithCapacity:[self.stringOne length]+1];
        if (self.stringOne && self.stringTwo) {
            // initialize an empty 2d grid of [stringOne length] columns and [stringTwo length] rows
            for (int i = 0; i <= [self.stringOne length]; i++) {
                [_editGrid addObject:[NSMutableArray arrayWithCapacity:[self.stringTwo length]+1]];
                for (int j = 0; j <= [self.stringTwo length]; j++) {
                    [_editGrid[i] addObject:@(0)];
                }
            }

            // populate the default grid
            for (int i = 0; i < [self.stringOne length]; i++) {
                _editGrid[i][0] = @(i);
                for (int j = 0; j < [self.stringTwo length]; j++) {
                    _editGrid[0][j] = @(j);
                }
            }
        }
    }
    return _editGrid;
}

// Calculate the Levenshtein edit-distance between two strings - to wit,
// the number of characters that need to be substituted, inserted, or deleted
// to transform stringOne into stringTwo.
- (NSNumber *)editDistance {
    if (self.stringOne && self.stringTwo) {
        for (int i = 1; i <= [self.stringOne length]; i++) {
            for (int j = 1; j <= [self.stringTwo length]; j++) {
                [self setEditDistanceStepWithIndexOne:i andIndexTwo:j];
            }
        }
        _editDistance = [[self.editGrid lastObject] lastObject];
    }else {
        _editDistance = @(0);
    }
    return _editDistance;
}

- (void)setEditDistanceStepWithIndexOne:(int)indexOne andIndexTwo:(int)indexTwo {
    if ([self.stringOne characterAtIndex:indexOne-1] == [self.stringTwo characterAtIndex:indexTwo-1]) {
        self.editGrid[indexOne][indexTwo] =  self.editGrid[indexOne - 1][indexTwo - 1];
    } else {
        // get scores for the three possible next steps
        NSNumber *a = self.editGrid[indexOne - 1][indexTwo];
        NSNumber *b = self.editGrid[indexOne][indexTwo - 1];
        NSNumber *c = self.editGrid[indexOne - 1][indexTwo - 1];
        
        // set the correct grid square to the lowest of the possible scores
        NSNumber *lowestScore =  MIN(a, MIN(b,c));
        self.editGrid[indexOne][indexTwo] = @([lowestScore intValue] + 1);
    }

}

@end
