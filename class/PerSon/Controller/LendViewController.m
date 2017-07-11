//
//  LendViewController.m
//  图书管理
//
//  Created by lixue on 16/5/9.
//  Copyright © 2016年 lixue. All rights reserved.
//


#import "LendViewController.h"
#import "Lend.h"
#import "LendTableViewCell.h"
#import "LendHeadView.h"
#import "BookDetailViewController.h"
#import "BookDetail.h"
@interface LendViewController ()<NoNetWorkViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)LendHeadView *headView;
@property(nonatomic,strong)NSArray *lenarray;
@end

@implementation LendViewController

-(NSArray *)lenarray{
    if (_lenarray == nil) {
        _lenarray = [NSArray array];
    }
    return _lenarray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =LXViewBacColor;
    self.title = @"已借书籍";
    self.automaticallyAdjustsScrollViewInsets =NO;
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
    NSMutableString *URLstring = [NSMutableString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/rent"];
    if (session.length!=0) {
        NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
        [paramas setObject:session forKey:@"session"];
        NSLog(@"session :%@",session);
        [[LXHTTPHelperClass shareInstanse]LXPOST:URLstring parameters:paramas Value:^(id responseObject) {
            [GMDCircleLoader hideFromView:self.view animated:YES];
            self.lenarray = [Lend objectArrayWithKeyValuesArray:responseObject[@"Detail"]];
            [self setupTableView];
            [self setupHeadView];
            [self.tableView reloadData];
        } Error:^(NSError *error) {
            
        }];
    }

}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,140+64 , self.view.bounds.size.width, self.view.bounds.size.height-(140+StatusHeight+NavigationBarHeight)) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
-(void)setupHeadView{
    LendHeadView *headView =[[LendHeadView alloc]init];
    headView.backgroundColor  = [UIColor whiteColor ];
    headView.frame = CGRectMake(0, StatusHeight+NavigationBarHeight, Viewwidth, 120);
    headView.haveLendCount = self.lenarray.count;
    headView.canLendCount =self.lenarray.count;
    for (int i=0; i<self.lenarray.count; i++) {
        Lend *lend = self.lenarray[i];
        if ([lend.State isEqualToString:@"本馆续借"]) {
            headView.lendAgainCount = self.headView.lendAgainCount+1;
        }
        else if([lend.State isEqualToString:@"过期暂停"]){
            headView.outDateCount =self.headView.outDateCount+1;
        }
    }
    [headView initHeadView];
    [self.view addSubview:headView];
    self.headView = headView;
}
//cell的重用机制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Lend*model = self.lenarray[indexPath.row];
    LendTableViewCell*cell = [LendTableViewCell addLendTableViewCell:tableView];
    cell.lend = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.block = ^(UIButton *bt,UILabel *dateLb){
        NSLog(@"%@",bt.titleLabel.text);
        NSString *title = bt.titleLabel.text;
        if ([title isEqualToString:@"我要续借"]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"session"]);
            
            dic[@"session"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
            dic[@"barcode"] = model.Barcode ;
            dic[@"department_id"] = model.Department_id ;
            dic[@"library_id"] = model.Library_id;
            [[LXHTTPHelperClass shareInstanse]LXPOST:[NSString urlStringWithpath:USER_RENEW_URL paramas:nil] parameters:dic Value:^(id responseObject) {
                if (responseObject[@"Result"]) {
                    [MBProgressHUD showMessage:@"续借成功"];
                        [bt setTitle:@"本管续借" forState:UIControlStateNormal];
                    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    dateLb.text = responseObject[@"Detail"];
                    

                    
                }
            } Error:^(NSError *error) {
                
            }];
        }
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lenarray.count;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Lend *lend = self.lenarray[indexPath.row];
    return lend.cellHeight ;
}
-(void)refershView{
    [self requestData];
}
@end
