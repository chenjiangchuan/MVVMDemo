//
//  KeychainItemWrapper.h
//  YLB
//
//  Created by chenjiangchuan on 16/10/13.
//  Copyright © 2016年 Sayee Intelligent Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainItemWrapper : NSObject
{
    NSMutableDictionary *keychainItemData;        // The actual keychain item data backing store.
    NSMutableDictionary *genericPasswordQuery;    // A placeholder for the generic keychain item query used to locate the item.
}

@property (nonatomic, retain) NSMutableDictionary *keychainItemData;
@property (nonatomic, retain) NSMutableDictionary *genericPasswordQuery;

// Designated initializer.
- (id)initWithAccount:(NSString *)account service:(NSString *)service accessGroup:(NSString *) accessGroup;

- (id)initWithIdentifier: (NSString *)identifier accessGroup:(NSString *) accessGroup;
- (void)setObject:(id)inObject forKey:(id)key;
- (id)objectForKey:(id)key;

// Initializes and resets the default generic keychain item data.
- (void)resetKeychainItem;

@end
