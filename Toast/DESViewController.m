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

- (IBAction)checkGuess:(id)sender {
    // TODO
}

- (void)UpdateUI {
    self.resultsLabel = [NSString stringWithFormat:@"It's closer to %@ than to %@.", self.game.betterGuess, self.game.worseGuess];
}

- (DESGame *)game {
    if (!_game) _game = [[DESGame alloc] init];
    return _game;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
