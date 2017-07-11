//
//  RankViewController.m
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//


#import "RankViewController.h"
#import "Rank.h"
#import "RankCell.h"
#import "BookDetailViewController.h"
@interface RankViewController ()
@property (nonatomic,assign)NSInteger size;
@end

@implementation RankViewController
-(NSString *)type{
    return nil;
}
-(NSMutableArray *)rankArray{
    if (_rankArray== nil) {
        _rankArray = [NSMutableArray array];
    }
    return _rankArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LXViewBacColor;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.header.autoChangeAlpha = YES;
    [self setupRefersh];
    [self.tableView.header beginRefreshing];
}
-(void)setupRefersh{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)loadNewData{
    self.size = 20;
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"type"] = self.type;
    NSInteger size = self.size;
    paramas[@"size"] = @(size);
    [[LXHTTPHelperClass shareInstanse]LXGET:@"http://api.xiyoumobile.com/xiyoulibv2/book/rank" parameters:paramas Value:^(id responseObject) {
        self.size = self.size+20
        ;
        _rankArray = [Rank objectArrayWithKeyValuesArray:responseObject[@"Detail"]];
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    } Error:^(NSError *error) {
        NSLog(@" %@",error);
    }];
    
}
-(void)loadMoreData{
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"type"] = self.type;
    NSInteger size = self.size;
    paramas[@"size"] = @(size);
    [[LXHTTPHelperClass shareInstanse]LXGET:@"http://api.xiyoumobile.com/xiyoulibv2/book/rank" parameters:paramas Value:^(id responseObject) {
        self.size = self.size+10;
        NSMutableArray *temparray  = [Rank objectArrayWithKeyValuesArray:responseObject[@"Detail"]];
        if (temparray.count == 10) {
            [self.tableView.footer noticeNoMoreData];
        }
        else{
            for (int i = 0; i<_rankArray.count; i++) {
                [temparray removeObjectAtIndex:0];//每次都移除第一个
            }
            [_rankArray addObjectsFromArray:temparray];
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];
        }
    } Error:^(NSError *error) {
         [self.tableView.footer endRefreshing];
    }];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Rank *rank = self.rankArray[indexPath.row];
    RankCell *cell = [RankCell addRankCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.rank = rank;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.footer.hidden = (self.rankArray.count == 0);
    return self.rankArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Rank *rank = self.rankArray[indexPath.row];
    return rank.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    Rank*model = self.rankArray [indexPath.row];
    BookDetailViewController *bookDeatilVc = [[BookDetailViewController alloc]init];
    bookDeatilVc.bookIdentifierType = @"id";
    bookDeatilVc.BookBarcode = model.LibarayId;
    [self.navigationController pushViewController:bookDeatilVc animated:YES];
    }
@end
