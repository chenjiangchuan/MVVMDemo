//
//  JCModel.h
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCModel : NSObject

/** 照片名称 */
@property (nonatomic, strong) NSString *photoName;
/** 缩略图地址 */
@property (nonatomic, strong) NSString *thumbnailURL;

@end
