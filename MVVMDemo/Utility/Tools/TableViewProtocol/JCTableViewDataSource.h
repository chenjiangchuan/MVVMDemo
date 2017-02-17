//
//  JCTableViewDataSource.h
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//
//  对TableView的dataSource进行封装，从Controller脱离出来，更加简化Controller
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JCTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, copy) NSArray *array;

@end
