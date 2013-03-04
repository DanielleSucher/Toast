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
        _editGrid = [NSMutableArray arrayWithCapacity:[self.stringOne length]];
        if (self.stringOne && self.stringTwo) {
            // initialize an empty 2d grid of [stringOne length] columns and [stringTwo length] rows
            for (int i = 0; i < [self.stringOne length]; i++) {
                [_editGrid addObject:[NSMutableArray arrayWithCapacity:[self.stringTwo length]]];
                for (int j = 0; j < [self.stringTwo length]; j++) {
                    [_editGrid[i] addObject:@(0)];
                }
            }

            // populate the grid
            for (int i = 0; i < [self.stringOne length]; i++) {
                _editGrid[i][0] = @(i);  // column 0: 0,1,2,3,4,...
                for (int j = 0; j < [self.stringTwo length]; j++) {
                    _editGrid[0][j] = @(j);  // row 0: 0,1,2,3,4,...
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
        for (int i = 0; i < [self.stringOne length]; i++) {
            for (int j = 0; j < [self.stringTwo length]; j++) {
                [self setEditDistanceStepWithIndexOne:i
                                             indexTwo:j
                                         characterOne:[self.stringOne characterAtIndex:i]
                                      andCharacterTwo:[self.stringTwo characterAtIndex:j]];
            }
        }
        _editDistance = self.editGrid[[self.stringOne length] -1][[self.stringTwo length] -1];
    }else {
        _editDistance = @(0);
    }
    return _editDistance;
}

- (void)setEditDistanceStepWithIndexOne:(int)indexOne
                               indexTwo:(int)indexTwo
                           characterOne:(unichar)characterOne
                        andCharacterTwo:(unichar)characterTwo {
    // get scores for the three possible next steps
    int a = 0;
    int b = 0;
    int c = 0;
    if (indexOne > 0) {
        a = [self.editGrid[indexOne - 1][indexTwo] intValue] + 1;
        if (indexTwo > 0) b = [self.editGrid[indexOne - 1][indexTwo - 1] intValue] + (characterOne != characterTwo);
    }
    if (indexTwo > 0) c = [self.editGrid[indexOne][indexTwo - 1] intValue] + 1;
    
    // set the correct grid square to the lowest of the possible scores
    int lowestScore =  MIN(a, MIN(b,c));
    self.editGrid[indexOne][indexTwo] = @(lowestScore);
}

@end
