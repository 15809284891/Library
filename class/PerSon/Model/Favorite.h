//
//  Favorite.h
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Favorite : NSObject
@property(nonatomic,copy)NSString*result;
@property(nonatomic,copy)NSString *Author;
@property(nonatomic,copy)NSString *BookID;
@property(nonatomic,copy)NSString *ISBN;
@property(nonatomic,copy)NSString *largeImage;
@property(nonatomic,copy)NSString *Pub;
@property(nonatomic,copy)NSString *Sort;
@property(nonatomic,copy)NSString *Title;
@property(nonatomic,copy)NSString *SubTitle;
@property (nonatomic,assign,readonly)CGFloat cellHeight;
@property(assign,nonatomic,getter=isCheck)BOOL checked;
@property(assign,nonatomic,getter=isDelete)BOOL deleted;
@property(nonatomic,strong)NSMutableArray *favoriteArray;
-(void)initFavorite:(NSDictionary *)dic;
@end
