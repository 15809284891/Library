//
//  PersonViewController.m
//  点了么
//
//  Created by lixue on 16/5/19.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "setViewController.h"
#import "LoginController.h"
#import "ProblemViewController.h"
#import "AboutusViewController.h"
#import "ChangePwdViewController.h"
#import "SDImageCache.h"
#import "SSKeychain.h"
#import "NSString+LXExtension.h"
@interface setViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic)UITableView *mytableView;
@property(nonatomic)NSArray *array;
@property(nonatomic,copy)NSString *cacheSize;
@end

@implementation setViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:@"upDateSize" object:nil];
    [self refreshTableView];
    self.title = @"设置";
    self.array = @[@"清除缓存",@"2G/3G/4G下显示图片",@"常见问题",@"关于我们",@"修改密码",@"退出当前账户"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:242/255.0 green:92/255.0 blue:90/255.0 alpha:1.0];
    self.view.backgroundColor =  [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
    

    self.mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, StatusHeight+NavigationBarHeight+20, self.view.bounds.size.width, 300)];
    self.mytableView .delegate = self;
    self.mytableView .dataSource = self;
    self.mytableView.backgroundColor = [UIColor whiteColor];
   [self.view addSubview:self.mytableView];
    }
//获取文件夹大小
-(long long )folderSizeWithPath:(NSString *)path{
    long long folderSize =0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return 0;
    }
    NSEnumerator *childFles = [[fileManager subpathsAtPath:path] objectEnumerator];
    NSString *fileName;
    while (((fileName=[childFles nextObject]))!=nil) {
        NSString *fileAbsolutePath = [path stringByAppendingString:fileName];
//        NSLog(@"%@",fileAbsolutePath);
        folderSize+=[self fileSizeWithPath:fileAbsolutePath];
    }
    return folderSize;
    
}
//计算文件大小
-(long long)fileSizeWithPath:(NSString *)path{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]){
        return [[manager attributesOfItemAtPath:path error:nil] fileSize];
    }
    return 0;}
-(NSString *)caculateCacheSize{
    //存储Etag文件etag.Archiver的大小+SDWebImage缓存的图片大小+NSURLCache缓存的大小
    //获取cache路径
    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *etagPath = [path stringByAppendingString:@"/etag.Archiver"];
    long long etagSize = [self fileSizeWithPath:etagPath];
    NSString *cachePath = [path stringByAppendingString:@"/lixue.library/fsCachedData/"];
    long long cacheSize = [self folderSizeWithPath:cachePath];
    long long totleSize = [[SDImageCache sharedImageCache] getSize]+cacheSize+etagSize;
    return [NSString stringWithFileSize:totleSize];
}
-(void)refreshTableView{
    NSLog(@"刷新tableView");
    self.cacheSize = [self caculateCacheSize];
    NSLog(@"闲杂文件大侠  :%@",self.cacheSize);
    [self.mytableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
//cell的重用机制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == 1){
        UISwitch *isShowImage = [[UISwitch alloc]init];
        isShowImage.onTintColor = LXbarTintColor;
        [isShowImage addTarget:self action:@selector(isShowImageAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:isShowImage];
        [isShowImage makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.right).offset(-30);
            make.width.equalTo(40);
            make.centerY.equalTo(cell.centerY);
        }];
    }
    else
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    cell.textLabel.text = self.array[indexPath.row ];
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存   %@",self.cacheSize];
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSLog(@"清除缓存");
        [[SDImageCache sharedImageCache]clearDisk];
        [[NSURLCache sharedURLCache]removeAllCachedResponses];
        NSString *path =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSLog(@"%@",path);
        NSString *etagPath = [path stringByAppendingString:@"/etag.Archiver"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager removeItemAtPath:etagPath error:NULL]) {
            NSLog(@"Removed successfully");
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.cacheSize= @"";
//        [cell.textLabel setNeedsDisplay];
                [self.mytableView reloadData];
    }
    else if (indexPath.row == 2) {
        ProblemViewController *problemVc = [[ProblemViewController alloc]init];
        self.navigationController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:problemVc animated:YES];
    }
    else if (indexPath.row == 3){
        AboutusViewController *aboutVC=[[AboutusViewController alloc]init];
        self.navigationController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    else if (indexPath.row == 4){
//        NSString *serviceName = @"cn.lixue";
//        NSArray *temp = [[SSKeychain accountsForService:serviceName]lastObject];
//        NSString *userName = [temp valueForKey:@"acct"];
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:userName]==NULL) {
//            [SVProgressHUD showInfoWithStatus:@"请先登录"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//        }
//        else{
//        
//        [self.navigationController pushViewController:[[ChangePwdViewController alloc]init]animated:YES];
//        }
    }
    else
        [self Loginout];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)Loginout{
    NSString *serviceName = ServiceName;
    NSArray *temp = [[SSKeychain accountsForService:serviceName]lastObject];
    NSString *userName = [temp valueForKey:@"acct"];
    NSString *session = [[NSUserDefaults standardUserDefaults] objectForKey:@"session"];
    if (session.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }

    else{
        [SSKeychain deletePasswordForService:serviceName account:userName];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"session"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginOut" object:nil];
        LoginController  *login = [[LoginController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    
    }
}
-(void)postNotfication{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clearInfo" object:nil];
}
-(void)outDateAction{
    
}
-(void)isShowImageAction{
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
