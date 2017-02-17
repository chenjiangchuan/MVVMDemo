//
//  JCTableViewCell.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/13.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "JCTableViewCell.h"
#import "JCModel.h"

#define HScreen [[UIScreen mainScreen] bounds].size.height
#define WScreen [[UIScreen mainScreen] bounds].size.width

@interface JCTableViewCell ()

/** 缩略图 */
@property (nonatomic, weak) UIImageView *thumbnailImageView;
/** 图片名字 */
@property (nonatomic, weak) UILabel *photoNameLabel;

@end

@implementation JCTableViewCell

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
    }
    return self;
}

#pragma mark - Getter and Setter

- (void)setModel:(JCModel *)model {
    _model = model;
   
    [_thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnailURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    _photoNameLabel.text = model.photoName;
}

@end
