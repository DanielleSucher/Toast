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
@property (readwrite, nonatomic) NSString *currentBestGuess;
@property (readwrite, nonatomic) NSString *worseGuess;
@property (readwrite, nonatomic) NSMutableString *history;
@property (readwrite, nonatomic) BOOL gameOver;
@end

@implementation DESGame

- (void)comparePreviousGuessWithNewGuess:(NSString *)newGuess {
    newGuess = [newGuess lowercaseString];
    [self.guesses addObject:newGuess];
    NSNumber *newScore = [self score:newGuess];
    [self.guessScores addObject:newScore];
    [self updateBetterAndWorseGuesses:newGuess
                   givenNewGuessScore:newScore];
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
    [self.history appendFormat:@"It's more like %@ than like %@.\n\n", self.currentBestGuess, self.worseGuess];
}

- (void)updateBetterAndWorseGuesses:(NSString *)newGuess givenNewGuessScore:(NSNumber *)newScore {
    if (self.guessScores[[self indexOfCurrentBestGuess]] >= newScore) {
        self.worseGuess = self.currentBestGuess;
        self.currentBestGuess = newGuess;
    } else {
        self.worseGuess = newGuess;
    }
}

- (int)indexOfCurrentBestGuess {
    return [self.guesses indexOfObject:self.currentBestGuess];
}

// use the list of the 5000 most common words in English to pick 
// a random word to be the answer
// the list is from http://www.englishclub.com/vocabulary/common-words-5000.htm
// with all <3 letter words and words with ' or - removed
- (NSString *)randomCommonWord {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"commonwords"
                                                         ofType:@"txt"];
    NSArray *commonWords = [[NSString stringWithContentsOfFile:filePath
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL]
                            componentsSeparatedByString:@"\n"];
    NSUInteger randomIndex = arc4random() % [commonWords count];
    return commonWords[randomIndex];
}

#pragma mark getters

@synthesize word = _word;
- (NSString *)word {
    if (!_word) _word = [self randomCommonWord];
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

- (NSString *)currentBestGuess {
    if (!_currentBestGuess) _currentBestGuess = @"toast";
    return _currentBestGuess;
}

@end
