//
//  DESHistoryViewController.m
//  Toast
//
//  Created by Danielle Sucher on 3/4/13.
//  Copyright (c) 2013 Danielle Sucher. All rights reserved.
//

#import "DESHistoryViewController.h"

@interface DESHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextField;

@end

@implementation DESHistoryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.historyTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"toastHistory"];
}

#pragma mark

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
