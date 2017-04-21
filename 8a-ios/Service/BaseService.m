//
//  BaseService.m
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "BaseService.h"

@interface BaseService() {
    
}

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BaseService

- (void)requestGetWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block
{
    
    [[BaseService shared].manager GET:[NSString stringWithFormat:@"%@%@",url,path] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(YES,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(NO,error);
    }];
}

- (void)requestPostWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block
{

    [[BaseService shared].manager POST:[NSString stringWithFormat:@"%@%@",url,path] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(YES, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(NO, error);
    }];
}

- (void)requestDeleteWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block
{
    [[BaseService shared].manager DELETE:[NSString stringWithFormat:@"%@%@",url,path] parameters:params				  success:^(NSURLSessionDataTask *task, id responseObject)
     {
         block(YES,responseObject);
     }
                                 failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         block(NO,error);
     }];
    
}

- (void)requestPutWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params  withResponse:(void(^)(BOOL success,id res))block
{
    [[BaseService shared].manager DELETE:[NSString stringWithFormat:@"%@%@",url,path] parameters:params				  success:^(NSURLSessionDataTask *task, id responseObject)
     {
         block(YES,responseObject);
     }
                                 failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         block(NO,error);
     }];
}

#pragma mark - Private methdos
+(BaseService *)shared{
    static BaseService *shared;
    if (!shared) {
        shared = [[BaseService alloc] init];
        NSURL *baseUrl = [NSURL URLWithString:DomainURL];
        shared.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        shared.manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        shared.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return shared;
}


@end
