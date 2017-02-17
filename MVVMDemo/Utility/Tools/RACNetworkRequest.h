//
//  RACNetworkRequest.h
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/16.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import <Foundation/Foundation.h>
// pod 'AFNetworking', '~> 3.0'
#import <AFNetworking/AFNetworking.h>
// pod 'ReactiveCocoa', '~> 2.5'
#import <ReactiveCocoa/ReactiveCocoa.h>
// pod 'MJExtension'
#import <MJRefresh/MJRefresh.h>

#define SingleH(name)  +(instancetype)share##name;

//ARC
#if __has_feature(objc_arc)
#define SingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

#else
//MRC
#define SingleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release\
{\
}\
\
-(instancetype)retain\
{\
return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
return MAXFLOAT;\
}
#endif

@interface RACNetworkRequest : NSObject <NSCopying,NSMutableCopying>

SingleH(RACNetworkRequest)

/**
 *  @author chenjiangchuan, 17-02-16 15:02:34
 *
 *  post请求
 *
 *  @param headerField 请求头字典
 *  @param urlString   请求的URL地址
 *  @param parameters  参数
 *  @param modeClass   接收到服务器返回数据后，需要转换的模型Class
 *
 *  @return 带有返回数据的RACSignal
 */
+ (RACSignal *)postHeaderField:(NSDictionary *)headerField
                       withURL:(NSString *)urlString
                    parameters:(id)parameters
                     modeClass:(Class)modeClass;

/**
 *  @author chenjiangchuan, 17-02-16 17:02:13
 *
 *  get请求
 *
 *  @param headerField 请求头字典
 *  @param urlString  请求的URL地址
 *  @param parameters 参数
 *  @param modeClass  接收到服务器返回数据后，需要转换的模型Class
 *
 *  @return 带有返回数据的RACSignal
 */
+ (RACSignal *)getHeaderField:(NSDictionary *)headerField
                      withURL:(NSString *)urlString
                   parameters:(id)parameters
                    modeClass:(Class)modeClass;

@end
