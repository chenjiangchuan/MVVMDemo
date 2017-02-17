//
//  RACJCTableViewCell.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/14.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "RACJCTableViewCell.h"
#import "RACJCModel.h"

@interface RACJCTableViewCell ()

/** 显示缩略图 */
@property (nonatomic, weak) UIImageView *thumbnailImageView;
/** 图片名字 */
@property (nonatomic, weak) UILabel *photoNameLabel;

@end

@implementation RACJCTableViewCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 50, self.bounds.size.height)];
        imageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:imageView];
        self.thumbnailImageView = imageView;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(65, 0,  self.bounds.size.width - 55, self.bounds.size.height)];
        [self.contentView addSubview:label];
        self.photoNameLabel = label;
        
        RAC(self.thumbnailImageView, image) = [[[RACObserve(self, model.thumbnailURL) ignore:nil] map:^id(NSString *thumbnailURL) {
            
            return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[[UIImageView alloc] init] sd_setImageWithURL:[NSURL URLWithString:thumbnailURL] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (!error) {
                        [subscriber sendNext:image];
                        [subscriber sendCompleted];
                    }
                }];
                
                return nil;
            }] subscribeOn:[RACScheduler scheduler]];
            
        }] switchToLatest];
        
        RAC(self.photoNameLabel, text) = [RACObserve(self, model.photoName) map:^id(NSString *photoName) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                if (![photoName isEqualToString:@""]) {
                    [subscriber sendNext:photoName];
                } else {
                    [subscriber sendNext:@"照片没有名字"];
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    
    // 让cell在每次重用的时候都去disposable创建的信号
    [self.rac_prepareForReuseSignal subscribeNext:^(UIImage *image) {
        self.thumbnailImageView.image = nil;
    }];
    
    return self;
}

@end
