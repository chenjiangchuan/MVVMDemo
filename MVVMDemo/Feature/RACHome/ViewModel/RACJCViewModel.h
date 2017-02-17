//
//  RACJCViewModel.h
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/14.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACJCViewModel : NSObject

/** username */
@property (nonatomic, copy) NSString *username;
/** password */
@property (nonatomic, copy) NSString *password;

/** 登录按钮是否有效 */
@property (nonatomic, strong, readonly) RACSignal *validLoginSignal;
/** 点击登录按钮后执行的RACCommand */
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
