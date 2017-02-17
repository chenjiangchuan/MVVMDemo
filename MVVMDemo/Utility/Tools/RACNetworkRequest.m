//
//  RACNetworkRequest.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/16.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "RACNetworkRequest.h"

@implementation RACNetworkRequest

SingleM(RACNetworkRequest)

#pragma mark - Init

+ (AFHTTPSessionManager *)sharedHTTPSessionManager {
    
    static AFHTTPSessionManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        
        // 超时时间
        manager.requestSerializer.timeoutInterval = 10.0f;
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/plain", @"text/javascript", nil];
        
        // 设置支持https
        [self customSecurityPolicy];
    });
    return manager;
}

#pragma mark - Private Methods

/**
 *  @author chenjiangchuan, 17-02-16 15:02:43
 *
 *  支持https请求，项目中不需要导入证书
 */
+ (AFSecurityPolicy *)customSecurityPolicy {
    
    AFSecurityPolicy * securityPolicy= [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    [securityPolicy setValidatesDomainName:NO];
    return securityPolicy;
}

/**
 *  @author chenjiangchuan, 17-02-16 17:02:03
 *
 *  设置请求的协议头
 *
 *  @param headerField 协议头对应的字典
 *  @param manager     AFHTTPSessionManager对象
 */
+ (void)setupHttpHeaderField:(NSDictionary *)headerField
         withSessionManager:(AFHTTPSessionManager *)manager {
    
    if (headerField.count == 0 || !headerField)  return;
    
    // 使用RAC对NSDictionary进行遍历
    [headerField.rac_sequence.signal subscribeNext:^(id x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        // 设置协议头
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }];
   
 
}

/**
 *  @author chenjiangchuan, 17-02-16 15:02:57
 *
 *  真正处理post请求的地方
 *
 *  @param headerField 请求头
 *  @param urlString   URL地址
 *  @param parameters  参数
 *
 *  @return RACSignal
 */
+ (RACSignal *)privatePosttHeaderField:(NSDictionary *)headerField
                               withURL:(NSString *)urlString
                            parameters:(id)parameters {
   
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPSessionManager *manager = [self sharedHTTPSessionManager];
        [self setupHttpHeaderField:headerField withSessionManager:manager];
        
        NSURLSessionDataTask *dataTask =
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self handleResponseObject:responseObject withSubscriber:subscriber];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [subscriber sendError:error];
        }];
        
        // 结束后取消请求
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
    
}

/**
 *  @author chenjiangchuan, 17-02-16 17:02:01
 *
 *  真正处理get请求的地方
 *
 *  @param headerField 请求头
 *  @param urlString   URL地址
 *  @param parameters  参数
 *
 *  @return RACSignal
 */
+ (RACSignal *)privateGettHeaderField:(NSDictionary *)headerField
                              withURL:(NSString *)urlString
                           parameters:(id)parameters {
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPSessionManager *manager = [self sharedHTTPSessionManager];
        [self setupHttpHeaderField:headerField withSessionManager:manager];
        
        NSURLSessionDataTask *dataTask =
        [manager GET:urlString
          parameters:parameters
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 
            [self handleResponseObject:responseObject withSubscriber:subscriber];
                 
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [subscriber sendError:error];
            
        }];
        
        // 结束后取消请求
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

/**
 *  @author chenjiangchuan, 17-02-16 15:02:55
 *
 *  处理从服务器返回的数据
 *
 *  @param responseObject 返回的数据
 *  @param subscriber     订阅者
 */
+ (void)handleResponseObject:(id  _Nullable)responseObject
              withSubscriber:(id<RACSubscriber>)subscriber {
    
    // 这个方法要根据服务器返回的实际数据进行处理
    /*
        假设现在服务器成功返回：
     "code": "0",
     "msg": "成功",
     
     失败返回：
     "code": "1",
     "msg": "失败",
     */
    NSString *msg = responseObject[@"msg"];
    if ([msg isEqualToString:@"成功"]) {
        [subscriber sendNext:responseObject];
        [subscriber sendCompleted];
    } else { // 失败
        NSError *error = [NSError errorWithDomain:@"requestDataError"
                                             code:-1
                                         userInfo:responseObject];
        [subscriber sendError:error];
    }
}

#pragma mark - Public Methods

+ (RACSignal *)postHeaderField:(NSDictionary *)headerField
                       withURL:(NSString *)urlString
                    parameters:(id)parameters
                     modeClass:(Class)modeClass {
    
   return [[self privatePosttHeaderField:headerField withURL:urlString parameters:parameters] map:^id(id responseObject) {
       if (!modeClass) {
           return responseObject;
       } else {
           return [modeClass mj_objectWithKeyValues:responseObject];
       }
    }];
}

+ (RACSignal *)getHeaderField:(NSDictionary *)headerField
                      withURL:(NSString *)urlString
                   parameters:(id)parameters
                    modeClass:(Class)modeClass; {
    
    return [[self privateGettHeaderField:headerField withURL:urlString parameters:parameters] map:^id(id responseObject) {
        if (!modeClass) {
            return responseObject;
        } else {
            return [modeClass mj_objectWithKeyValues:responseObject];
        }
    }];
}

@end
