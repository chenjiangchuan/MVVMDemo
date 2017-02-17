//
//  HomeTableViewDataSource.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "HomeTableViewDataSource.h"
#import "JCTableViewCell.h"
#import "JCModel.h"

@implementation HomeTableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    JCModel *model = self.array[indexPath.row];
    
    cell.model = model;
    return cell;
}

@end
