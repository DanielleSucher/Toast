//
//  DESGame.m
//  Toast
//
//  Created by Danielle Sucher on 3/2/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

#import "DESGame.h"
#import "DESLevenshtein.h"

@interface DESGame()
@property (readwrite, nonatomic) NSString *betterGuess;
@property (readwrite, nonatomic) NSString *worseGuess;
@property (readwrite, nonatomic) BOOL gameOver;
@end

@implementation DESGame

// designated initializer
- (id)init {
    self = [super init];
    if (self) {
        self.gameOver = NO;
        [self.guesses addObject:@"toast"];
        [self.guessScores addObject:[self score:@"toast"]];
    }
    return self;
}

@synthesize word = _word;
- (NSString *)word {
    // TODO return random word once the dictionary db is set up
    if (!_word) _word = @"trust";
    return _word;
}

- (void)comparePreviousGuessandNewGuess:(NSString *)newGuess {
    [self.guesses addObject:newGuess];
    [self.guessScores addObject:[self score:newGuess]];
    if ([newGuess isEqualToString:self.word]) self.gameOver = YES;
    int guessCount = [self.guesses count];
    if (self.guessScores[guessCount - 1] > self.guessScores[guessCount - 2]) {
        self.betterGuess = self.guesses[guessCount - 1];
        self.worseGuess = self.guesses[guessCount - 2];
    } else {
        self.betterGuess = self.guesses[guessCount - 2];
        self.worseGuess = self.guesses[guessCount - 1];
    }
}

- (NSNumber *)score:(NSString *)guess {
    // TODO
}

@end
