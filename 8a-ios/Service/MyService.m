//
//  MyService.m
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "MyService.h"

@implementation MyService

+ (MyService *)shared
{
    static MyService *singleton;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[MyService alloc] init];
    });
    
    return singleton;
    
}

-(void)requestConfirmationCodeWithPhoneNum:(NSString *)phoneNum withCompletion:(void(^)(BOOL success,id res))block{
    
    [self requestPostWithURL: DomainURL atPath: RequestConfirmationCode withParams: @{@"phoneNumber": phoneNum } withResponse:^(BOOL success, id res) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:res options:0 error:nil];
            block(success, dict);
        }
        else {
            block(success, res);
        }
    }];
}

-(void)loginWithPhoneNum:(NSString *)phoneNum confirmationCode: (NSString *)code withCompletion:(void(^)(BOOL success,id res))block{
    
    [self requestPostWithURL: DomainURL atPath: LoginWithCredentials withParams: @{@"phoneNumber": phoneNum, @"confirmationCode": code} withResponse:^(BOOL success, id res) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:res options:0 error:nil];
            block(success, dict);
        }
        else {
            block(success, res);
        }
    }];
}

-(void)loginWithEmail:(NSString *)email password: (NSString *)password withCompletion:(void(^)(BOOL success,id res))block {
    
    [self requestPostWithURL: DomainURL atPath: RequestConfirmationCode withParams: @{@"email": email, @"password": password} withResponse:^(BOOL success, id res) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:res options:0 error:nil];
            block(success, dict);
        }
        else {
            block(success, res);
        }
    }];
}

@end
