//
//  BookDetailViewController.m
//  图书管理
//
//  Created by lixue on 16/7/16.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "BookDetail.h"
#import "UIImageView+WebCache.h"
#import "BookDetailViewController.h"
#import "BookDetail.h"
#import "CirculationInfo.h"
#import "BasicInfoCell.h"
#import "CirculateInfoView.h"
#import "ReferBooks.h"
#import "RerferCell.h"
#import "BacImageCell.h"
#import "BasicIntoHead.h"
#import "CirculateViewController.h"
#import "ReferenceViewController.h"
#import "MJExtension.h"
#import "CirculationInfo.h"
#import "ReferBooks.h"
#import "DoubanInfo.h"
#import "BookData.h"
#import "BookImage.h"

@interface BookDetailViewController ()<UITableViewDataSource,UITableViewDelegate,BasicIntoHeadDelegate>
@property(nonatomic)NSArray *bookArray;
@property(nonatomic)UITableView *tableView;
@property(nonatomic)BasicInfoCell *basicInfoCell;
@property(nonatomic)UITableViewCell *cell;
@property(nonatomic)BacImageCell *bacImageCell;
@property(nonatomic,strong)UILabel *TitleLb;
@property(nonatomic)CirculateInfoView *CirculateInfoView;
@property(nonatomic)RerferCell *rerferCell;
@property(nonatomic)NSArray *CirculationArray;
@property(nonatomic)NSArray *ReferArray;
@property(nonatomic)BasicIntoHead *basicInfoHeadView;
@property(nonatomic)BookDetail *bookdetail;
@property(nonatomic)AFHTTPSessionManager *manager;
@end

@implementation BookDetailViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.CirculationArray = [NSArray array];
        self.ReferArray = [NSArray array];
        self.bookdetail = [[BookDetail alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书籍详情";
    self.view.backgroundColor =LXViewBacColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [GMDCircleLoader setOnView:self.view withTitle:@"loading.." animated:YES];
    [[LXHTTPHelperClass shareInstanse]LXGET:[NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/book/detail/%@/%@",self.bookIdentifierType,self.BookBarcode] parameters:nil Value:^(id responseObject) {
        //        NSLog(@"aaaaaaaaaa :%@",responseObject);
        if ([responseObject[@"Detail"] isKindOfClass:[NSString class]]) {
            self.tableView = nil;
        }
        else{
            [GMDCircleLoader hideFromView:self.view animated:YES];
            self.bookdetail = [BookDetail objectWithKeyValues:responseObject[@"Detail"]];
            self.bookdetail.circulationInfoArray = [CirculationInfo objectArrayWithKeyValuesArray:responseObject[@"Detail"][@"CirculationInfo"]];
            self.bookdetail.ReferBooksArray = [ReferBooks objectArrayWithKeyValuesArray:responseObject[@"Detail"][@"ReferBooks"]];
            self.CirculationArray = self.bookdetail.circulationInfoArray;
            self.ReferArray = self.bookdetail.ReferBooksArray;
            self.bookdetail.doubanInfo = [DoubanInfo objectWithKeyValues:responseObject[@"Detail"][@"DoubanInfo"]];
            if ((responseObject[@"Detail"][@"DoubanInfo"]!=[NSNull null])&&(responseObject[@"Detail"][@"DoubanInfo"][@"Images"])!=[NSNull null]) {
                self.bookdetail.doubanInfo.Images = [BookImage objectWithKeyValues:responseObject[@"Detail"][@"DoubanInfo"][@"Images"]];
            }
            
            _tableView = [[UITableView alloc]initWithFrame: CGRectMake(0,20, Viewwidth, Viewheight-20) style:UITableViewStyleGrouped];//为什么不用加NavigationBar的高度
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.sectionFooterHeight = 0;
            _tableView.sectionHeaderHeight = 0;
            [self.view addSubview:_tableView];
            
            self.bacImageCell = [[BacImageCell alloc]init];
            /*为什么将下面这些代码放在init里面，顺序是 init-----viewDidLoad----在lendController里面赋值*/
            self.bacImageCell.frame = CGRectMake(0, 0, self.view.bounds.size.width,self.bacImageCell.frame.size.height);//如果是 cell.frame就会出问题
            self.basicInfoCell.frame = CGRectMake(0, 0, self.view.bounds.size.width,200);
            self.basicInfoHeadView = [[BasicIntoHead alloc]init];
            self.basicInfoHeadView.delegate = self;
        }

    } Error:^(NSError *error) {
        
    }];
}
-(void)favoriteAction{
}

#pragma mark - UITableViewCellDelegete
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [self.bacImageCell initContent:self.bookdetail];
        [cell.contentView addSubview:self.bacImageCell];
    }
 
    else if(indexPath.section == 1){
        cell.backgroundColor = [UIColor whiteColor];
        UIView *cellBac = [[UIView alloc]initWithFrame:CGRectMake(15, 5, self.view.frame.size.width-30, 200-10)];
        cellBac.backgroundColor = [UIColor whiteColor];
        cellBac.layer.masksToBounds = YES;
        cellBac.layer.cornerRadius = 5.0;
        [cell.contentView addSubview:cellBac];
        BasicInfoCell *basicInfoCell = [BasicInfoCell addBasicInfoCell:tableView];
        basicInfoCell.backgroundColor = [UIColor clearColor];
        basicInfoCell.bookDetail= self.bookdetail;
        [cellBac addSubview:basicInfoCell];
    }
    else if(indexPath.section == 2){

        UIView *bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
        bacView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        CirculateViewController *circulateVc = [[CirculateViewController alloc]init];
        [self addChildViewController:circulateVc];
        circulateVc.circulateArray = _CirculationArray;
        circulateVc.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, 180);
        [bacView addSubview:circulateVc.tableView];
        [cell.contentView addSubview:bacView];
    }
    else if(indexPath.section == 3){
        cell.backgroundColor = [UIColor whiteColor];
        UILabel *subjectLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, cell.contentView.frame.size.width-40, 30)];
        subjectLb.text = self.bookdetail.Subject;
        subjectLb.textColor= [UIColor darkGrayColor];
        [cell.contentView addSubview:subjectLb];
    }
    else if(indexPath.section == 4){
        UIView *bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
        bacView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        ReferenceViewController *referVc = [[ReferenceViewController alloc]init];
        [self addChildViewController:referVc];
        referVc.referArray = _ReferArray;
        referVc.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, 180);
        [bacView addSubview:referVc.tableView];
        [cell.contentView addSubview:bacView];
    }
    return cell;
  }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;//返回标题数组中元素的个数来确定分区的个数
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return 1;
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.bacImageCell.frame.size.height;
            
    }
    else if(indexPath.section == 1){
        return 210;
            
    }
    else if(indexPath.section == 2){
        return 180;
    }
    else if(indexPath.section == 3){
    return 80;
    }
    else if(indexPath.section == 4){
        return 180;
    }
    else
        return 0;
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
       return 0;

    }
    else
        return 60;
        
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3||section == 4||section ==2 ) {
        NSString *text = @"";
        NSString *imgStr = @"";
        if (section == 2) {
            text = @"流通情况";
            imgStr = @"2";
        }
        else if (section == 3) {
            text = @"图书主题";
            imgStr = @"3";
            
        }
        else {
            text = @"相关推荐";
            imgStr = @"4";
        }
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width ,60)];
        view3.backgroundColor =  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        UILabel *lanle3 = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 100, 40)];
        lanle3.font = [UIFont systemFontOfSize:18];
        UIImageView *imageV3 =[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];
        lanle3.text =text;
        [view3 addSubview:lanle3];
        imageV3.image = [UIImage imageNamed:imgStr];
        [view3 addSubview:imageV3];
        return view3;
    }
    else if (section == 1){
        self.basicInfoHeadView.frame  = CGRectMake(0, 0, self.view.bounds.size.width, 60);
        self.basicInfoHeadView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        [self.basicInfoHeadView.favirateBt addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside ];

        return self.basicInfoHeadView;
        
    }
    else
        return nil;
    
}
#pragma BasicInfoHeadDelegate
-(void)addFavirate:(UIButton *)bt{
    NSLog(@"%@",self.bookdetail.BookID);
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"session"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
    paramas[@"id"] = self.bookdetail.BookID;
    [[LXHTTPHelperClass shareInstanse]LXPOST:[NSString urlStringWithpath:USER_ADDFAV paramas:nil] parameters:paramas Value:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        NSString *str = responseObject[@"Detail"];
        if ([str isEqualToString:@"ADDED_SUCCEED"]) {
            [MBProgressHUD showMessage:@"收藏成功"];
        }
        else if([str isEqualToString:@"ALREADY_IN_FAVORITE"]){
            [MBProgressHUD showMessage:@"已收藏过了"];
        }
        else{
            [MBProgressHUD showMessage:@"收藏失败"];
        }
            

   
    } Error:^(NSError *error) {
        
    }];
}
@end
