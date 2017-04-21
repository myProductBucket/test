//
//  SignInViewController.m
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "SignInViewController.h"
#import "ConfirmCodeViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UIButon Actions

- (IBAction)getConfirmationCodeTouchUp:(UIButton *)sender {
    NSString *phoneNum = [self.phoneNumTF text];
    
    if (phoneNum == nil || [phoneNum length] < 8) {
        [self showAlertWithTitle:@"" message:@"Please input the valid phone number"];
        return;
    }
    
    unichar firstChar = [[self.phoneNumTF text] characterAtIndex:0];
    if (firstChar != '+') {
        phoneNum = [NSString stringWithFormat:@"+%@", phoneNum];
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[MyService shared] requestConfirmationCodeWithPhoneNum:phoneNum withCompletion:^(BOOL success, id res) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if (success) {
            if ([res[@"success"] isEqualToString:@"ok"]) {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"Success" message:res[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okA = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self showConfirmCodeVC:phoneNum];
                }];
                
                [alertC addAction:okA];
                
                [self presentViewController:alertC animated:YES completion:^{

                }];
            }
        }else {
            NSLog(@"%@", [res localizedDescription]);
            [self showAlertWithTitle:@"" message:@"Something went wrong. Please try again later!"];
        }
    }];
}

#pragma mark - Custom Methods

- (void)showConfirmCodeVC: (NSString *)phoneNum {
    ConfirmCodeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmCodeViewController"];
    [vc setPhoneNumber:phoneNum];
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
