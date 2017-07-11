//
//  UIButton+OringeImage.m
//  图书管理
//
//  Created by snow on 2017/5/12.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "UIImage+BtnImage.h"

@implementation UIImage (BtnImage)
+(UIImage *)withBtnImage:(UIImage *)image{
    CGFloat btnImageW = image.size.width * 0.5;
    CGFloat btnImageH = image.size.height * 0.5;
    UIImage *newBtnImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(btnImageH, btnImageW, btnImageH, btnImageW) resizingMode:UIImageResizingModeStretch];
    return newBtnImage;
}
@end
