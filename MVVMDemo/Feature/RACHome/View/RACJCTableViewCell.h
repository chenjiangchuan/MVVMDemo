//
//  RACJCTableViewCell.h
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/14.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACJCModel;

@interface RACJCTableViewCell : UITableViewCell

/** viewModel */
@property (nonatomic, strong) RACJCModel *model;

@end
