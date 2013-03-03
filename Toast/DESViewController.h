//
//  DESViewController.h
//  Toast
//
//  Created by Danielle Sucher on 3/2/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DESViewController : UIViewController
@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *wordsDB;
@end
