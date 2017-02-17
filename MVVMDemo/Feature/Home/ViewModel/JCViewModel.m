//
//  JCViewModel.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "JCViewModel.h"
#import "JCModel.h"

@implementation JCViewModel

- (void)headerRefreshRequestWithCallBack:(callBack)callBack {
    
    // 模拟网络请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"simulated.plist" ofType:nil];
            NSDictionary *result = [NSDictionary dictionaryWithContentsOfFile:path];
            
            NSMutableArray <JCModel *> *MArray = [JCModel mj_objectArrayWithKeyValuesArray:result[@"photo"]];
            
            callBack(MArray);
        });
    });
}

- (void)footerRefreshRequestWithCallback:(callBack)callBack {
    
    // 模拟网络请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSString *path = [[NSBundle mainBundle] pathForResource:@"simulated.plist" ofType:nil];
            NSDictionary *result = [NSDictionary dictionaryWithContentsOfFile:path];
            
            NSMutableArray <JCModel *> *MArray = [JCModel mj_objectArrayWithKeyValuesArray:result[@"photo"]];
            
            callBack(MArray);
        });
    });
}

@end
