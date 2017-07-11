//
//  mainViewController.m
//  图书管理
//
//  Created by lixue on 16/4/17.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "MainViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "DetailViewController.h"
#import "LXNewsCache.h"
#import "DataBaseTool.h"
#import "AnounceViewController.h"
#import "NewsViewController.h"
@interface MainViewController ()<NoNetWorkViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *newsArray;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation MainViewController
-(NSString *)type{
    return nil;
}
-(NSMutableArray *)newsArray{
    if (_newsArray == nil) {
//        _newsArray = [NSMutableArray array];
    }
    return _newsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
     [self setupRefersh];
    [self requestData];
    if ([self isKindOfClass:[AnounceViewController class]]) {
        _newsArray = [[[DataBaseTool shareDataBase]getAllNews:@"announce"]mutableCopy];
    }
    else{
        _newsArray = [[[DataBaseTool shareDataBase]getAllNews:@"news"] mutableCopy];
        
    }
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshView:) name:@"isNetWork" object:nil];
   }
-(void)refreshView:(NSNotification *)noticy{
    NSLog(@"------------------  %d",whetherHaveNetwork);
    if (whetherHaveNetwork){
        [self requestData];
    }
}
-(void)requestData{
    [self.tableView.header beginRefreshing];

}
-(void)setupRefersh{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Viewwidth, Viewheight-44-44-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)loadNewData{
    self.currentPage = 1;
    NSString *url = [NSString urlStringWithpath:NEWS_URL paramas:@{@"type":self.type,@"page":@(_currentPage)}];
    [[LXHTTPHelperClass shareInstanse]LXGET:url parameters:nil Value:^(id responseObject) {
         NSLog(@"%@",responseObject);
        _newsArray = [News objectArrayWithKeyValuesArray:responseObject[@"Detail"][@"Data"]];
        NSString *newsType = responseObject[@"Detail"][@"Type"];
        if ([newsType isEqualToString:@"公告"]) {
            newsType = @"announce";
        }
        else if ([newsType isEqualToString:@"新闻"]){
            newsType = @"news";
        }
        for (int i =0; i<_newsArray.count; i++) {
            ((News *)(_newsArray[i])).newsType = newsType;
            
            [[DataBaseTool shareDataBase] addNews:_newsArray[i]];
        }
        self.pages = [responseObject[@"Detail"][@"Pages"] intValue];
        self.currentPage = self.currentPage+1;
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    } Error:^(NSError *error) {
        [self.tableView.header endRefreshing];
        [MBProgressHUD showMessage:@"网络无连接"];
    }];
}
-(void)loadMoreData{
    if (self.pages == self.currentPage) {
        [self.tableView.footer noticeNoMoreData];
    }
    else{
        NSInteger currentPage = self.currentPage;
        NSString *url = [NSString urlStringWithpath:NEWS_URL paramas:@{@"type":self.type,@"page":@(_currentPage)}];
        [[LXHTTPHelperClass shareInstanse]LXGET:url parameters:nil Value:^(id responseObject) {
            NSArray *tempArray = [News objectArrayWithKeyValuesArray:responseObject[@"Detail"][@"Data"]];
            NSString *newsType = responseObject[@"Detail"][@"Type"];
            if ([newsType isEqualToString:@"公告"]) {
                newsType = @"announce";
            }
            else if ([newsType isEqualToString:@"新闻"]){
                newsType = @"news";
            }
            for (int i =0; i<tempArray.count; i++) {
                ((News *)(tempArray[i])).newsType = newsType;
            }
            
            [_newsArray  addObjectsFromArray:tempArray];
            self.currentPage = self.currentPage+1;
            [self.tableView.footer endRefreshing];
            [self.tableView reloadData];

        } Error:^(NSError *error) {
            [MBProgressHUD showMessage:@"网络无连接"];
            [self.tableView.footer endRefreshing];
        }];
            
    }
}
#pragma mark - UITableViewCellDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [NewsCell addNewsCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.newsArray[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.footer.hidden = (_newsArray.count == 0);
    return _newsArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    News *model = _newsArray[indexPath.row];
    return model.cellHeight;;
}
#pragma mark - UITableViewCellDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];
     self.navigationController.hidesBottomBarWhenPushed = YES;
    detailVc.news = _newsArray[indexPath.row];
}

-(void)refershView{
    [self requestData];
}

@end
