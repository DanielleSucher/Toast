//
//  DESViewController.m
//  Toast
//
//  Created by Danielle Sucher on 3/2/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

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
    
//    // Get the documents directory
//    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsDir = dirPaths[0];
//    
//    // Build the path to the database file
//    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"toastDB"]];
//    
//    NSFileManager *filemgr = [NSFileManager defaultManager];
//    
//    if ([filemgr fileExistsAtPath: _databasePath ] == NO) {
//        const char *dbpath = [_databasePath UTF8String];
//        
//        if (sqlite3_open(dbpath, &_wordsDB) == SQLITE_OK) {
//            sqlite3_close(_wordsDB);
//        } else {
////            _status.text = @"Failed to find wordlist";
//        }
//    }
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
    if ([self.guessField.text length] > 0) {
        [self.game comparePreviousGuessWithNewGuess:self.guessField.text];
        [self UpdateUI];
    }
    [self.guessField resignFirstResponder];
}

- (void)UpdateUI {
    self.guessCountLabel.text = [NSString stringWithFormat:@"guesses: %d", [self.game.guesses count] -1];
    self.previousGuessLabel.text = [NSString stringWithFormat:@"Is it more like %@", self.game.betterGuess];
    self.guessField.text = nil;
    if (self.game.gameOver) {
        self.resultsLabel.text = @"You won!";
    } else {
        self.resultsLabel.text = [NSString stringWithFormat:@"It's more like %@ than like %@.", self.game.betterGuess, self.game.worseGuess];
    }
    [self updateUserDefaultsHistory];
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
