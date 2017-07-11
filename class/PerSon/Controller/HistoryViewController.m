//
//  LendViewController.m
//  图书管理
//
//  Created by lixue on 16/5/9.
//  Copyright © 2016年 lixue. All rights reserved.
//
#import "HistoryViewController.h"
#import "History.h"
#import "HistoryCell.h"
#import "BookDetailViewController.h"
@interface HistoryViewController ()<NoNetWorkViewDelegate>
@property(nonatomic,weak)UITableView *historyTable;
@property(nonatomic,strong)NSArray *historyArray;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的足迹";
    self.historyArray = [NSArray array];
    self.view.backgroundColor = LXViewBacColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!whetherHaveNetwork) {
        NoNetWorkView *netWorkV = [[NoNetWorkView alloc]initWithFrame:self.view.bounds];
        netWorkV.delegate = self;
        [self.view addSubview:netWorkV];
    }
    else{
        [self requestData];
    }

    
}
-(void)requestData{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [GMDCircleLoader setOnView:self.view withTitle:@"loading" animated:YES];
    NSString *session = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
    NSMutableString *URLstring = [NSMutableString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/history"];
    [[LXHTTPHelperClass shareInstanse]LXPOST:URLstring parameters:@{@"session":session} Value:^(id responseObject) {
        [GMDCircleLoader hideFromView:self.view animated:YES];
        id isHaveRecord = responseObject[@"Detail"];
        if ([isHaveRecord isKindOfClass:[NSString class]]) {
            UIImageView *nilView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            nilView.image = [UIImage imageNamed:@"noHistoryu"];
            [self.view addSubview:nilView];
        }
        else{
            History *history =[[History alloc]init];
            [history initHistoryData:responseObject];
            self.historyArray = history.historyArray;
            [self setupTableView];
        }
        
        
    } Error:^(NSError *error) {
        
    }];

}
-(void)setupTableView{
    UITableView *historyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Viewwidth,Viewheight)];
    historyTable.backgroundColor = [UIColor whiteColor];
    historyTable.dataSource = self;
    historyTable.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    historyTable.delegate = self;
    [self.view addSubview:historyTable];
    self.historyTable = historyTable;
}
//cell的重用机制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    History *history = self.historyArray[indexPath.row];
    HistoryCell *cell = [HistoryCell addHistoryCell:tableView];
    cell.history = history;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyArray.count;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    History *history = self.historyArray[indexPath.row];
    NSLog(@"%lf",history.cellHeight);
    return history.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    History*model = self.historyArray[indexPath.row];
    BookDetailViewController *bookDeatilVc = [[BookDetailViewController alloc]init];
    bookDeatilVc.bookIdentifierType = @"barcode";
    bookDeatilVc.BookBarcode = model.Barcode;
    [self.navigationController pushViewController:bookDeatilVc animated:YES];
    self.navigationController.hidesBottomBarWhenPushed = YES;

}
-(void)refershView{
    [self requestData];
}
@end
