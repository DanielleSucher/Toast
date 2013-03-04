//
//  DESViewController.h
//  Toast
//
//  Created by Danielle Sucher on 3/2/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DESViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *guessField;
}
@property (weak, nonatomic) IBOutlet UITextField *guessField;
@end
