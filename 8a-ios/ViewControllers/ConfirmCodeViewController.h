//
//  ConfirmCodeViewController.h
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmCodeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextField *confirmCodeTF;

- (void)setPhoneNumber: (NSString *)sender;

@end
