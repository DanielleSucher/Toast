//
//  DESViewController.m
//  Toast
//
//  Created by Danielle Sucher on 3/2/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

#import <sqlite3.h>
#import "DESViewController.h"
#import "DESGame.h"

@interface DESViewController ()
@property (weak, nonatomic) IBOutlet UILabel *previousGuessLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessCountLabel;
@property (strong, nonatomic) DESGame *game;
@end

@implementation DESViewController

@synthesize guessField = _guessField;

- (void)viewDidLoad {
    [super viewDidLoad]; 
    _guessField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self checkGuess];
    return YES;
}

- (IBAction)returnFromSubmitButton:(id)sender {
    [self checkGuess];
}

- (void)checkGuess {
    if ([self guessExists] && [self.guessField.text length] > 0) {
        [self.game comparePreviousGuessWithNewGuess:self.guessField.text];
        [self UpdateUI];
    } else {
        self.resultsLabel.text = [NSString stringWithFormat:@"%@ is not a real word. Try a different guess!", self.guessField.text];        
    }
    [self resetGuessField];
}

- (void)UpdateUI {
    self.guessCountLabel.text = [NSString stringWithFormat:@"guesses: %d", [self.game.guesses count] -1];
    self.previousGuessLabel.text = [NSString stringWithFormat:@"Is it more like %@", self.game.currentBestGuess];
    if (self.game.gameOver) {
        self.resultsLabel.text = @"You won!";
    } else {
        self.resultsLabel.text = [NSString stringWithFormat:@"It's more like %@ than like %@.", self.game.currentBestGuess, self.game.worseGuess];
    }
    [self updateUserDefaultsHistory];
}

- (void)resetGuessField {
    self.guessField.text = nil;
    [self.guessField resignFirstResponder];
}

- (BOOL) guessExists {
    BOOL exists = NO;
    sqlite3 *wordsDB;
    sqlite3_stmt *statement;
    
    NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"sqlite3"];
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &wordsDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT 1 FROM words WHERE word='%@'", self.guessField.text];
        const char *query = [querySQL UTF8String];
        if (sqlite3_prepare_v2(wordsDB, query, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                exists = YES;
            }
            sqlite3_finalize(statement);
        } else {
            NSLog(@"Failed with message '%s'.", sqlite3_errmsg(wordsDB));
        }
        sqlite3_close(wordsDB);
    } else {
        NSLog(@"Failed to open database!");
    }
    return exists;
}

- (DESGame *)game {
    if (!_game) _game = [[DESGame alloc] init];
    return _game;
}

-(void)updateUserDefaultsHistory {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (userDefaults) {
        [userDefaults setObject:self.game.history forKey:@"toastHistory"];
        [userDefaults synchronize];
    }
}

@end
