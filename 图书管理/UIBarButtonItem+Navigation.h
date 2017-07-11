//
//  UIBarButtonItem+Navigation.h
//  图书管理
//
//  Created by snow on 2017/5/2.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (navigation)
+(UIBarButtonItem *)barButtonItemwithImage:(NSString *)imageName target:(id)target action:(SEL)action;
+(UIBarButtonItem *)barButtonItemWithNomalTitle:(NSString *)NomaTitle selectedTitle:(NSString *)selectedTitle size:(CGSize)size targer:(id)target action:(SEL)action;
@end
