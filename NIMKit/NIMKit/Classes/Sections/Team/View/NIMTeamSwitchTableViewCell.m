//
//  NTESTeamSwitchTableViewCell.m
//  NIM
//
//  Created by amao on 5/29/15.
//  Copyright (c) 2015 Netease. All rights reserved.
//

#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "NIMTeamSwitchTableViewCell.h"
#import "UIView+NIM.h"

@implementation NIMTeamSwitchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _switcher = [[UISwitch alloc] initWithFrame:CGRectZero];
        _switcher.onTintColor = kUIColorFromRGB(0xDBC48C);
        [_switcher addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_switcher];
    }
    return self;
}

- (void)valueChanged:(id)sender {
    if (_switchDelegate && [_switchDelegate respondsToSelector:@selector(cell:onStateChanged:)])
    {
        [_switchDelegate cell:self onStateChanged:_switcher.isOn];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat right             = 20.f;
    self.switcher.nim_right   = self.nim_width - right;
    self.switcher.nim_centerY = self.nim_height * .5;
}


@end
