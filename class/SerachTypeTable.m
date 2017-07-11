//
//  SerachTypeTable.m
//  图书管理
//
//  Created by snow on 2017/5/21.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "SerachTypeTable.h"
#import "BookSortTool.h"
#import "SearchType.h"
@implementation SerachTypeTable

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle= UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 100;
    }
    return self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SearchType *type = [SearchType shareInstance];
    BookSortTool *tool = [[BookSortTool alloc]initWithFrame:CGRectMake(27.5, 0, cell.contentView.mj_w, 100)];
    tool.tag=indexPath.section;
    NSDictionary *tmpdic = type.titles_types[type.titles[indexPath.section]];
    NSArray *tmpArr = tmpdic[@"chainese"];
    [tool creatViewWithViewTitle:type.titles[indexPath.section] withSubViews:tmpArr cols:4];
    [cell.contentView addSubview:tool];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *myCell=[self tableView:tableView cellForRowAtIndexPath:indexPath];//获取当前indexPath中的cell实例
    if( myCell == nil ){
        return 0;
        
    }else{
        BookSortTool *tool = [myCell.contentView viewWithTag:indexPath.section];
        return  tool.frame.size.height;
        
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    SearchType *type = [SearchType shareInstance];
    return type.titles.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    SearchType *type = [SearchType shareInstance];
    return type.titles[section];
}

@end
