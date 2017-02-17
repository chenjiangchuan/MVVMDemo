//
//  JCTableViewCell.h
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCModel;

@interface JCTableViewCell : UITableViewCell

/** Model */
@property (nonatomic, strong) JCModel *model;

@end
