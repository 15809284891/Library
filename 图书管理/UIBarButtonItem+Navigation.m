//
//  UIBarButtonItem+Navigation.m
//  图书管理
//
//  Created by snow on 2017/5/2.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "UIBarButtonItem+Navigation.h"
#import "UIButton+AllStatus.h"
@implementation UIBarButtonItem (navigation)
+(UIBarButtonItem *)barButtonItemwithImage:(NSString *)imageName target:(id)target action:(SEL)action{
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize imageSize = [searchButton allstatusButtonWithImage:imageName];
    searchButton.bounds = CGRectMake(0,0, imageSize.width, imageSize.height);
    [searchButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc]initWithCustomView:searchButton];
}
+(UIBarButtonItem *)barButtonItemWithNomalTitle:(NSString *)NomaTitle selectedTitle:(NSString *)selectedTitle size:(CGSize)size targer:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, size.width, size.height);
    [button setTitle:NomaTitle forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc]initWithCustomView:button];

}
@end

