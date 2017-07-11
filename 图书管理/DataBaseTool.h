//
//  DataBaseTool.h
//  图书管理
//
//  Created by snow on 2017/5/31.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class News;
@class personModel;
@class DetailModel;
@interface DataBaseTool : NSObject
+(instancetype)shareDataBase;
-(BOOL)addNews:(News *)news;
-(void)addUserInfo:(personModel *)perSon;
-(NSArray *)getAllNews:(NSString *)type;
-(personModel *)getUserInfo;
@end
