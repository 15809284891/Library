//
//  LXTabBarItem.m
//  图书管理
//
//  Created by snow on 2017/5/2.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "LXTabBarItem.h"

@implementation LXTabBarItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode  = UIViewContentModeScaleAspectFit;//保证图片不被拉伸
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, self.frame.size.width, 25);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 25, self.frame.size.width,19);
}
-(void)setHighlighted:(BOOL)highlighted{
    
}
@end
