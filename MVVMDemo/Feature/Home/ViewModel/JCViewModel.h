//
//  JCViewModel.h
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JCModel;

typedef void(^callBack)(NSArray <JCModel *> *array);

@interface JCViewModel : NSObject

/**
 *  @author chenjiangchuan, 17-02-13 13:02:39
 *
 *  tableView头部刷新的网络请求
 *
 *  @param callBack 返回对应的模型数组
 */
- (void)headerRefreshRequestWithCallBack:(callBack)callBack;

/**
 *  @author chenjiangchuan, 17-02-13 13:02:08
 *
 *  tableView尾部刷新的网络请求
 *
 *  @param callBack 返回对应的模型数组
 */
- (void)footerRefreshRequestWithCallback:(callBack)callBack;

@end
