//
//  SYUUID.m
//  YLB
//
//  Created by chenjiangchuan on 16/10/13.
//  Copyright © 2016年 Sayee Intelligent Technology. All rights reserved.
//

#import "SYUUID.h"
#import  <Security/Security.h>
#import "KeychainItemWrapper.h"

@implementation SYUUID

#pragma mark - 保存和读取UUID

+ (void)saveUUIDToKeyChain {
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithAccount:@"Identfier" service:@"AppName" accessGroup:nil];
    NSString *string = [keychainItem objectForKey: (__bridge id)kSecAttrGeneric];
    if([string isEqualToString:@""] || !string){
        [keychainItem setObject:[self getUUIDString] forKey:(__bridge id)kSecAttrGeneric];
    }
}

+ (NSString *)readUUIDFromKeyChain {
    
    KeychainItemWrapper *keychainItemm = [[KeychainItemWrapper alloc] initWithAccount:@"Identfier" service:@"AppName" accessGroup:nil];
    NSString *UUID = [keychainItemm objectForKey: (__bridge id)kSecAttrGeneric];
    return UUID;
}

+ (NSString *)getUUIDString {
    
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
    NSString *uuidString = [(__bridge NSString*)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}

@end
