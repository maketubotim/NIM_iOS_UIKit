//
//  NIMAdvancedTeamIconCell.m
//  BusinessCardProject
//
//  Created by 鼎耀 on 2018/12/4.
//  Copyright © 2018年 Linyoung. All rights reserved.
//

#import "NIMAdvancedTeamIconCell.h"
#import "Masonry.h"

@interface NIMAdvancedTeamIconCell ()

@end

@implementation NIMAdvancedTeamIconCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(60);
    }];

    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.centerX.equalTo(self.imageView);
        make.height.mas_equalTo(20);
    }];
    
}

@end
