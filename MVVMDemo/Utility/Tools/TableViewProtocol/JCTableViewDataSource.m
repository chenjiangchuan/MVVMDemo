//
//  JCTableViewDataSource.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "JCTableViewDataSource.h"

@implementation JCTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

@end
