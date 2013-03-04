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
@property (readwrite, nonatomic) NSMutableString *history;
@property (readwrite, nonatomic) BOOL gameOver;
@end

@implementation DESGame

- (void)comparePreviousGuessWithNewGuess:(NSString *)newGuess {
    newGuess = [newGuess lowercaseString];
    [self.guesses addObject:newGuess];
    [self.guessScores addObject:[self score:newGuess]];
    [self updateBetterAndWorseGuesses];
    [self updateHistory];
    if ([newGuess isEqualToString:self.word]) {
        self.gameOver = YES;
        [self.history appendFormat:@"Game over! The word was: %@", [self.word uppercaseString]];
    }
        
}

- (NSNumber *)score:(NSString *)guessedWord {
    DESLevenshtein *levenshtein = [[DESLevenshtein alloc] initWithStringOne:guessedWord andStringTwo:self.word];
    return [levenshtein editDistance];
}

- (void)updateHistory {
    [self.history appendFormat:@"It's more like %@ than like %@.\n\n", self.betterGuess, self.worseGuess];
}

- (void)updateBetterAndWorseGuesses {
    int guessCount = [self.guesses count];
    if (self.guessScores[guessCount - 1] > self.guessScores[guessCount - 2]) {
        self.betterGuess = self.guesses[guessCount - 1];
        self.worseGuess = self.guesses[guessCount - 2];
    } else {
        self.betterGuess = self.guesses[guessCount - 2];
        self.worseGuess = self.guesses[guessCount - 1];
    }
}


#pragma mark getters

@synthesize word = _word;
- (NSString *)word {
    // TODO return random word once the dictionary db is set up
    if (!_word) _word = @"trust";
    return _word;
}

- (NSMutableArray *)guesses {
    if (!_guesses) {
        _guesses = [[NSMutableArray alloc] init];
        [_guesses addObject:@"toast"];
    }
    return _guesses;
}

- (NSMutableArray *)guessScores {
    if (!_guessScores) {
        _guessScores = [[NSMutableArray alloc] init];
        [_guessScores addObject:[self score:@"toast"]];
    }
    return _guessScores;
}

- (NSString *)history {
    if (!_history) _history = [NSMutableString stringWithString:@"Guess history:\n\n"];
    return _history;
}

@end
