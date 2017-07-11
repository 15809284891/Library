//
//  FavoriteViewController.m
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "FavoriteViewController.h"
#import "Favorite.h"
#import "FavoriteCell.h"
#import "BookScrollerViewControler.h"
@interface FavoriteViewController ()<UITableViewDelegate,UITableViewDataSource,NoNetWorkViewDelegate>
@property(nonatomic)Favorite *favorite;
@property(nonatomic)UIButton *Editbutton;
@property(nonatomic)UIButton *deletebutton;
@property(nonatomic)NSMutableArray *favoriteArray;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    if (!whetherHaveNetwork) {
        NoNetWorkView *netWorkV = [[NoNetWorkView alloc]initWithFrame:self.view.bounds];
        netWorkV.delegate = self;
        [self.view addSubview:netWorkV];
    }
    else{
        [self requstData];
        }
    [self setupFooterView];
}
-(void)requstData{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [GMDCircleLoader setOnView:self.view withTitle:@"loading" animated:YES];
    NSString *session = [[NSUserDefaults  standardUserDefaults]objectForKey:@"session"];
    NSMutableString *URLstring = [NSMutableString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/favoriteWithImg"];
    [[LXHTTPHelperClass shareInstanse]LXPOST:URLstring parameters:@{@"session":session} Value:^(id responseObject) {
        [GMDCircleLoader hideFromView:self.view animated:YES];
        id isHaveRecord = responseObject[@"Detail"];
        if ([isHaveRecord isKindOfClass:[NSString class]]) {
            UIImageView *nilView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            nilView.image = [UIImage imageNamed:@"noFavInfo"];
            [self.view addSubview:nilView];
            self.Editbutton.enabled = NO;
        }
        else{
            Favorite *favorite = [[Favorite alloc]init];
            [favorite initFavorite:responseObject];
            self.favoriteArray = favorite.favoriteArray;
            [self setuoTaleView];
        }
        
        
    } Error:^(NSError *error) {
        
    }];

}
-(void)refreshView{
    [self requstData];
}
-(void)setupFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, Viewheight-40, Viewwidth, 40)];
    [self.view addSubview:footerView];
    UIButton *allselectBt = [UIButton buttonWithType:UIButtonTypeCustom];
    allselectBt.frame = CGRectMake(20, 5, 40, 25);
    allselectBt.tag = 0;
    [allselectBt setTitle:@"全选" forState: UIControlStateNormal];
    allselectBt.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [allselectBt addTarget:self action:@selector(footerBTClick:) forControlEvents:UIControlEventTouchUpInside];
    [allselectBt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [footerView addSubview:allselectBt];
    
    UIButton *okBt = [UIButton buttonWithType:UIButtonTypeCustom];
    okBt.frame = CGRectMake(Viewwidth-80, 0, 80, 40);
    [okBt setTitle:@"确定" forState: UIControlStateNormal];
    okBt.tag = 1;
    okBt.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [okBt addTarget:self action:@selector(footerBTClick:) forControlEvents:UIControlEventTouchUpInside];
    [okBt setBackgroundImage:[UIImage imageNamed:@"导航栏"] forState:UIControlStateNormal];
    [okBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerView addSubview:okBt];

}
-(void)footerBTClick:(UIButton *)bt{
    if (bt.tag == 0) {
        NSLog(@"全选");
        bt.selected = !bt.selected;
        if (bt.selected) {
            for (Favorite *f in self.favoriteArray) {
                [f setDeleted:YES];
            }
        }
        else{
            for (Favorite *f in self.favoriteArray) {
                [f setDeleted:NO];
            }
        }
        
        [self.tableView reloadData];
        
    }
    else if (bt.tag == 1){
        for (Favorite *f in self.favoriteArray) {
            if (f.isDelete) {
                NSString *serviceName = ServiceName;
                NSArray *temp = [[SSKeychain accountsForService:serviceName]lastObject];
                NSString *userName = [temp valueForKey:@"acct"];
                NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
                paramas[@"session"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
                paramas[@"id"] = f.BookID;
                paramas[@"username"] = userName;
                [[LXHTTPHelperClass shareInstanse]LXPOST:@"http://api.xiyoumobile.com/xiyoulibv2/user/DelFav" parameters:paramas Value:^(id responseObject) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.favoriteArray indexOfObject:f] inSection:0];
                    //先 remove 再 delete
                    [self.favoriteArray removeObject:f];
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                } Error:^(NSError *error) {
                    
                }];
            }
            
        }
    }
}
-(void)setuoTaleView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h-40) style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(64+10, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    self.Editbutton.enabled = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSorce
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Favorite *favorite = self.favoriteArray[indexPath.row];
    FavoriteCell *cell = [FavoriteCell addFavoriteCell:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.favorite = favorite;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.favoriteArray.count;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Favorite *favorite = self.favoriteArray[indexPath.row];
    return favorite.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        Favorite *f = self.self.favoriteArray[indexPath.row];//操作模型，因为cell的循环利用会导致数据紊乱
        [f setDeleted:!f.isDelete];
        [self.tableView reloadData];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath   {
    self.tableView.editing = !self.tableView.editing;
    Favorite *f  = self.favoriteArray[indexPath.row];
    NSString *serviceName = ServiceName;
    NSArray *temp = [[SSKeychain accountsForService:serviceName]lastObject];
    NSString *userName = [temp valueForKey:@"acct"];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"session"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
    paramas[@"id"] = f.BookID;
    paramas[@"username"] = userName;
    [[LXHTTPHelperClass shareInstanse]LXPOST:[NSString urlStringWithpath:USER_DELFAV paramas:nil] parameters:paramas Value:^(id responseObject) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.favoriteArray indexOfObject:f] inSection:0];
        //先 remove 再 delete
        [self.favoriteArray removeObject:f];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } Error:^(NSError *error) {
        
    }];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
    
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"取消收藏";
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark - NoNetWorkDelegate
-(void)refershView{
    [self requstData];
}
@end

