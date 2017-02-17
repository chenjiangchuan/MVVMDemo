//
//  RACJCViewModel.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/14.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "RACJCViewModel.h"
#import "RACNetworkRequest.h"

NSString *const ServerURL = @"https://api.sayee.cn:28084";
NSString *const LoginURL = @"users/login.json?";

@implementation RACJCViewModel

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        // 登录按钮enable的值取决于username和password，username必须为手机号，password必须大于6
        _validLoginSignal = [[RACSignal
                              combineLatest:@[RACObserve(self, username), RACObserve(self, password)]
                              reduce:^(NSString *username, NSString *password) {
            @strongify(self);
            return @([self isMobileNumber:username] && password.length >= 6);
        }] distinctUntilChanged];
        
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            // 在这里进行网络请求
            NSString *url = [ServerURL stringByAppendingPathComponent:LoginURL];
            
            NSString *uuid = [SYUUID readUUIDFromKeyChain];
            NSDictionary *headerField = @{@"uuid" : uuid};
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"tick"] = [self currentMilliSecond];
            parameters[@"username"] = self.username;
            
            return [[RACNetworkRequest postHeaderField:headerField
                                               withURL:url
                                            parameters:parameters
                                             modeClass:nil] doNext:^(id x) {
                NSLog(@"loginCommand\nx= %@", x);
                
                NSString *code = x[@"code"];
                if ([code isEqualToString:@"0"]) {
                    // 跳转到下一个界面
                    [[Routable sharedRouter] open:@"TableViewController"];
                }
            }];
        }];
    }
    return self;
}

#pragma mark - Private Methods

/**
 *  @author chenjiangchuan, 17-02-17 10:02:05
 *
 *  判断字符串是否为有效的手机号
 *
 *  @param mobileNumber 手机号
 *
 *  @return 有效手机号返回YES
 */
- (BOOL)isMobileNumber:(NSString *)mobileNumber {
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"; // 移动
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$"; // 联通
    NSString * CT = @"^1((33|53|81|8[09])[0-9]|349)\\d{7}$"; // 电信
    NSString * CR = @"^1(7[0-9]|4[0-9]|8[56])\\d{8}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextextcr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CR];
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestct evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES)
        || ([regextextcr evaluateWithObject:mobileNumber] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  @author chenjiangchuan, 17-02-17 11:02:08
 *
 *  获取当前的毫秒时间
 *
 *  @return 毫秒时间
 */
- (NSString *)currentMilliSecond {
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
    return [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
}

@end
