//
//  SYUUID.h
//  YLB
//
//  Created by chenjiangchuan on 16/10/13.
//  Copyright © 2016年 Sayee Intelligent Technology. All rights reserved.
//
//  获取UUID
//

#import <Foundation/Foundation.h>

@interface SYUUID : NSObject

/**
 *  把UUID写入keychain中
 */
+ (void)saveUUIDToKeyChain;

/**
 *  从keychain中读取UUID
 *
 *  @return UUID
 */
+ (NSString *)readUUIDFromKeyChain;


+ (NSString *)getUUIDString;

@end
