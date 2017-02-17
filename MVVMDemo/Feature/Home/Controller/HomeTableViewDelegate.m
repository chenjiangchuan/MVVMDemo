//
//  HomeTableViewDelegate.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "HomeTableViewDelegate.h"
#import "JCModel.h"

@implementation HomeTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.array.count > 0) {
        
        JCModel *model = self.array[indexPath.row];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:model.photoName preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [vc presentViewController:alertController animated:YES completion:nil];
    }
}

@end
