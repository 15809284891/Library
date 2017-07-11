//
//  SearchType.m
//  图书管理
//
//  Created by snow on 2017/5/20.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "SearchType.h"
static SearchType *_type;
@implementation SearchType
+(SearchType *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _type = [[SearchType alloc]init];
    });
    return _type;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.wordTypes = @[@"所有题名",@"出版社",@"索书号",@"作者",@"标准号",@"主题词",@"图书条码",@"分类号",@"题名缩拼"];
        self.wordTypeindexs = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        
        self.matchMethods = @[@"前向匹配",@"模糊匹配",@"精确匹配"];
        self.matchMethodindexs = @[@"qx",@"mh",@"jq"];
        
        self.recordTypes = @[@"全部",@"中文图书",@"西文图书",@"日文图书",@"俄文图书",@"中文期刊",@"西文期刊",@"日文期刊",@"俄文期刊",@"中文报纸",@"西文报纸",@"数据库",@"年鉴"];
        self.recordTypeindexs = @[@"all",@"01",@"02",@"03",@"04",@"11",@"12",@"13",@"14",@"c1",@"e1",@"s1",@"z1"];
        self.orderscArray = @[@"顺序",@"逆序"];
        self.orderscArrayindexs = @[@"asc",@"desc"];
        self.orderbyArray = @[@"出版年",@"题目",@"责任者",@"出版社",@"标准号"];
        self.orderbyArrayindexs = @[@"pubdate_date",@"title",@"authors",@"publisher",@"isn"];
        _titles_types = @{
                          @"匹配方式":@{@"chainese":_matchMethods,
                                       @"number":_matchMethodindexs},
                          @"资料类型":@{@"chainese":_recordTypes,
                                     @"number":_recordTypeindexs},
                          @"排序顺序":@{@"chainese":_orderscArray,
                                     @"number":_orderscArrayindexs},
                          @"排序依据":@{@"chainese":_orderbyArray,
                                     @"number":_orderbyArrayindexs},
                          @"检索词类型":@{@"chainese":_wordTypes,
                                     @"number":_wordTypeindexs}
                                     };
        _titles =@[@"匹配方式",@"资料类型",@"排序顺序",@"排序依据",@"检索词类型"];
        self.paramasDic = [NSMutableDictionary dictionary];
        self.paramasDic[@"检索词类型"]= _wordTypeindexs[0];
        self.paramasDic[@"匹配方式"] = _matchMethodindexs[0];
        self.paramasDic[@"资料类型"]= _recordTypeindexs[0] ;
        self.paramasDic[@"排序顺序"] = _orderscArrayindexs[0];
        self.paramasDic[@"排序依据"]= _orderbyArrayindexs[0];
    }
    return self;
}
@end
