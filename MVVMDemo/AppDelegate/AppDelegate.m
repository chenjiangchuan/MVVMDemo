//
//  AppDelegate.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import "RACLoginViewController.h"

#define RACLogin

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 把UUID写入到keychain
    [SYUUID saveUUIDToKeyChain];

    // 设置根控制器
    UINavigationController *nav = [[UINavigationController alloc] init];
    nav.navigationBar.barTintColor=[UIColor colorWithRed:0.22f green:0.50f blue:0.78f alpha:1.00f];
    nav.navigationBar.tintColor=[UIColor whiteColor];
    nav.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self setupRoutable];
    [[Routable sharedRouter] setNavigationController:nav];
    
#ifdef RACLogin
    [[Routable sharedRouter] open:@"RACLoginViewController" animated:YES];
#else
    [[Routable sharedRouter] open:@"TableViewController" animated:YES];
#endif
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupRoutable {
    [[Routable sharedRouter] map:@"RACLoginViewController" toController:[RACLoginViewController class]];
    [[Routable sharedRouter] map:@"TableViewController" toController:[TableViewController class]];
}

@end
