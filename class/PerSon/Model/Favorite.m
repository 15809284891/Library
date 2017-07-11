//
//  Favorite.m
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "Favorite.h"

@implementation Favorite{
    CGFloat _cellHeight;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.favoriteArray = [NSMutableArray array ];
    }
    return self;
}
-(void)initFavorite:(NSDictionary *)dic{

    self.result = dic[@"Result"];
    NSArray *tempArray = dic[@"Detail"];
    for (int i=0; i<tempArray.count; i++) {
       
        NSDictionary *tempDic = tempArray[i];
        Favorite *favorite = [[Favorite alloc]init];
        if ([tempDic[@"Author"] isEqualToString:@""]) {
            favorite.Author = @"";
        }
        else{
            favorite.Author = tempDic[@"Author"];
        }
        if ([tempDic[@"Title"]isEqualToString:@""]) {
            favorite.Title = @"";
        }
        else{
            favorite.Title = tempDic[@"Title"];
            NSArray *TitleArray = [favorite.Title componentsSeparatedByString:@":"];
            self.SubTitle = TitleArray[0];
        }
        if ([tempDic[@"ID"]isEqualToString:@""]) {
             favorite.BookID = @"";
        }
        else{
            favorite.BookID = tempDic[@"ID"];
        }
        if([tempDic[@"ISBN"]isEqualToString:@""]){
            favorite.ISBN = @"";
        }
        else{
        favorite.ISBN = tempDic[@"ISBN"];
        }
        if (tempDic[@"Images"] == [NSNull null]) {
            favorite.largeImage = @"";
        }
        else{
        favorite.largeImage = tempDic[@"Images"][@"large"];
        }
        if ([tempDic[@"Pub"] isEqualToString:@""]) {
             favorite.Pub = @"";
        }
        else{
        favorite.Pub = tempDic[@"Pub"];
        }
        favorite.Sort = tempDic[@"Sort"];
        [self.favoriteArray addObject:favorite];
}

}
-(CGFloat)cellHeight{
    if (_cellHeight == 0) {
        CGSize size = CGSizeMake(screenW-110, MAXFLOAT);
        CGSize lableSize = [self.Title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil].size;
        _cellHeight = lableSize.height+87;
    }
    return _cellHeight;
}

@end
