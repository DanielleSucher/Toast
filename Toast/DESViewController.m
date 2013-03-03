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
@property (weak, nonatomic) IBOutlet UITextField *guessField;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *closestGuessLabel;
@property (strong, nonatomic) DESGame *game;
@end

@implementation DESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"toastDB"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO) {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_wordsDB) == SQLITE_OK) {
            sqlite3_close(_wordsDB);
        } else {
//            _status.text = @"Failed to find wordlist";
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

- (IBAction)checkGuess:(id)sender {
    [self.game comparePreviousGuessWithNewGuess:[self.guessField.text lowercaseString]];
    [self UpdateUI];
}

- (void)UpdateUI {
    self.guessCountLabel.text = [NSString stringWithFormat:@"guesses: %d", [self.game.guesses count]];
    self.closestGuessLabel.text = [self.game closestGuess];
    if (self.game.gameOver) {
        self.resultsLabel.text = @"You won!";
    } else {
        self.resultsLabel.text = [NSString stringWithFormat:@"It's closer to %@ than to %@.", self.game.betterGuess, self.game.worseGuess];
    }
}

- (DESGame *)game {
    if (!_game) _game = [[DESGame alloc] init];
    return _game;
}


@end
