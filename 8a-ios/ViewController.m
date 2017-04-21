//
//  ViewController.m
//  8a-ios
//
//  Created by Uncovered on 4/20/17.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Actions

- (IBAction)watchNewsTouchUp:(UIButton *)sender {
}

- (IBAction)reportNewsTouchUp:(UIButton *)sender {
    if (![self isSignedIn]) {
        [self showSignInVC];
    }else {
        // If the user already signed in, ...
    }
}

#pragma mark - Custom Methods

- (BOOL)isSignedIn {
    return NO;
}

- (void)showSignInVC {
    SignInViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
