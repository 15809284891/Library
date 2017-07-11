
//
//  DataBaseTool.m
//  图书管理
//
//  Created by snow on 2017/5/31.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "DataBaseTool.h"
#import "News.h"
#import "personModel.h"
static DataBaseTool *_DBCtl;
@interface DataBaseTool()<NSCopying,NSMutableCopying>{
    FMDatabase *_db;
}
@end
@implementation DataBaseTool
+(instancetype)shareDataBase{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _DBCtl = [[DataBaseTool alloc]init];
        [_DBCtl initDataBase];
    });
    return _DBCtl;
}
-(void)initDataBase{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"library.sqlite"];
    NSLog(@"%@",filePath);
    _db = [FMDatabase databaseWithPath:filePath];
    [_db open];
    NSString *newSql = @"CREATE TABLE IF NOT EXISTS 'news' ('title' VARCHAR(255), 'date' VARCHAR(255), 'NewsID'VARCHAR(255) PRIMARY KEY,'newsType' VARCHAR(255)) ";
    [_db executeUpdate:@"DROP TABLE user"];
    NSString *userSql = @"CREATE TABLE IF NOT EXISTS 'user' ('userID' VARCHAR(255) PRIMARY KEY,'name' VARCHAR(255),'department' VARCHAR(255))";
    NSLog(@"%@",userSql);
    [_db executeUpdate:userSql];
    [_db close];
}
-(BOOL)addNews:(News *)news{
    [_db open];
    [_db executeUpdate:@"INSERT INTO news(title,date,NewsID,newsType)VALUES(?,?,?,?)",news.title ,news.date,news.NewsID,news.newsType];
    [_db close];
    return YES;
}
-(NSArray *)getAllNews:(NSString *)type{
    [_db open];
    FMResultSet *rs= [_db executeQueryWithFormat:@"SELECT *FROM news WHERE  newsType = %@",type];
    NSMutableArray *dataArray = [[NSMutableArray array]init];
    
    while ([rs next]) {
        News *model = [[News alloc]init];
        model.title = [rs stringForColumn:@"title"];
        model.date = [rs stringForColumn:@"date"];
        model.NewsID = [rs stringForColumn:@"NewsID"];
        model.newsType = [rs stringForColumn:@"newsType"];
        [dataArray addObject:model];
    }
    [_db close];
    return  dataArray;
}
-(void)addUserInfo:(personModel *)perSon{
    [_db open];
    NSLog(@"要插入的数据%@",perSon.Name);
    [_db executeUpdate:@"INSERT INTO user(userID,name,department)VALUES(?,?,?)",perSon.ID,perSon.Name,perSon.Department];
    NSLog(@"插入成功了吗 %d", [_db executeUpdate:@"INSERT INTO user(userID,name,department)VALUES(?,?,?)",perSon.ID,perSon.Name,perSon.Department]?1:0);
    [_db close];
}
-(personModel *)getUserInfo{
    [_db open];
    FMResultSet *rs = [_db executeQuery:@"SELECT *FROM user "];
    personModel *model = [[personModel alloc]init];
    while ([rs next]) {
        model.Name = [rs stringForColumn:@"name"];
        model.ID = [rs stringForColumn:@"userID"];
        model.Department = [rs stringForColumn:@"department"];
        
    }
    [_db close];
    return model;
    
}
@end
