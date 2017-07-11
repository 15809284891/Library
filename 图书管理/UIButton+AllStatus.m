//
//  UIButton+AllStatus.m
//  图书管理
//
//  Created by snow on 2017/5/2.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "UIButton+AllStatus.h"

@implementation UIButton (allStatus)
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
-(CGSize)allstatusButtonWithImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    return image.size;
}
@end
