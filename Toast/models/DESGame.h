//
//  DESGame.h
//  Toast
//
//  Created by Danielle Sucher on 3/2/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESGame : NSObject

@property (readonly, nonatomic) NSString *word;
@property (readonly, nonatomic) NSString *currentBestGuess;
@property (readonly, nonatomic) NSString *worseGuess;
@property (readonly, nonatomic) NSMutableString *history;
@property (readonly, nonatomic) BOOL gameOver;

@property (strong, nonatomic) NSString *previousGuess;
@property (strong, nonatomic) NSMutableArray *guesses;
@property (strong, nonatomic) NSMutableArray *guessScores;

- (void)comparePreviousGuessWithNewGuess:(NSString *)newGuess;

@end
