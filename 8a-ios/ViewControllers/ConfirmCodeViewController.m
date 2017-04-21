//
//  ConfirmCodeViewController.m
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ConfirmCodeViewController.h"
#import "ProfileViewController.h"

@interface ConfirmCodeViewController () {
    NSString *phoneNum;
}

@end

@implementation ConfirmCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.errorLabel setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIButton Actions

- (IBAction)nextTouchUp:(UIButton *)sender {
    
    [self.errorLabel setHidden:YES];
    
    NSString *code = [self.confirmCodeTF text];
    if (code == nil || code.length < 4) {
        [self showAlertWithTitle:@"" message:@"Please input the valid code!"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[MyService shared] loginWithPhoneNum:phoneNum confirmationCode:code withCompletion:^(BOOL success, id res) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (success) {
            NSLog(@"Token: %@", res[@"token"]);
            [self showProfileVC];
        }else {
            [self.errorLabel setHidden:NO];
//            [self showAlertWithTitle:@"" message:@"Something went wrong! Please try again later!"];
        }
    }];
}

- (IBAction)notReceivedTouchUp:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Public Methods

- (void)setPhoneNumber: (NSString *)sender {
    phoneNum = sender;
}

#pragma mark - Custom Methods

- (void)showProfileVC {
    ProfileViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showAlertWithTitle: (NSString *)title message: (NSString *)message {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okA = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:okA];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

@end
