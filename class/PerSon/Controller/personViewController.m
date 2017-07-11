//
//  personViewController.m
//  图书管理
//
//  Created by lixue on 16/4/17.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "personViewController.h"
#import "LendViewController.h"
#import "HistoryViewController.h"
#import "personModel.h"
#import "LendViewController.h"
#import "FavoriteViewController.h"
#import "RootRankViewController.h"
#import "PersonView.h"
#import "FavoriteViewController.h"
#import "LoginController.h"
#import "RootRankViewController.h"
NSString *const  PINotifition = @"refreshPersonInfo";
@interface personViewController ()<PersonViewDelegate>
{
    NSString *receive;
    NSArray *arrayList;
}
@property(nonatomic,strong)UILabel *userName;
@property(nonatomic,strong)UILabel *num;
@property(nonatomic,strong)UILabel *major_lb;
@property(nonatomic,strong)personModel *person;
@end

@implementation personViewController
-(id)init{
    self = [super init];
    if (self) {
        //崩溃
        arrayList = @[@"我的借阅",@"我的收藏",@"我的足迹",@"排行榜"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = LXViewBacColor;
    NSString *session = [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupPersonHeadView];
    if (session.length == 0) {
        self.personView.person = nil;
    }
    //        请求个人信息
    else{
        [self setupPersonInfo];
    }
    [self setupTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshInfo:) name:PINotifition object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ClearPersonInfo:) name:@"LoginOut" object:nil];
}
-(void)refreshInfo:(NSNotification *)notify{
    NSLog(@"登录");
    [self setupPersonInfo];
    [self setupTableView];
}
-(void)ClearPersonInfo:(NSNotification *)notify{
    self.personView.person = nil;
    [self.tableView reloadData];
}
/*自定义navigationBar的titleLabel*/
 /*初始化个人信息*/
-(void)setupPersonHeadView{
    self.personView = [[PersonView alloc]init];
    self.personView.backgroundColor = [UIColor whiteColor];
    self.personView.frame = CGRectMake(0, 0, Viewwidth, 100);
    self.personView.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearInfo) name:@"clearInfo" object:nil];
}
// 请求个人信息
-(void)setupPersonInfo{
    NSString *URLstring = [NSString urlStringWithpath:USERINFO_URL paramas:nil];
    [[LXHTTPHelperClass shareInstanse]LXPOST:URLstring parameters:@{@"session":[[NSUserDefaults standardUserDefaults]objectForKey:@"session"]} Value:^(id responseObject) {
        id isHaveRecord = responseObject[@"Detail"];
        if ([isHaveRecord isKindOfClass:[NSString class]]) {
                     self.personView.person = nil;
        }
        else{
            personModel *tempPerson = [[personModel alloc]init];
            [tempPerson initPersonInfo:responseObject];
            self.person = tempPerson;
            self.personView.person = self.person;
        }

    } Error:^(NSError *error) {
        
    }];
}
-(void)clearInfo{
    self.personView.person = nil;
    [self.personView.ImageButton addTarget:self action:@selector(ImageClick:) forControlEvents:UIControlEventTouchUpInside];
}
/*初始化tableView*/
-(void)setupTableView{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0,64+20, Viewwidth, 320);
    _tableView. delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    _tableView. tableHeaderView =self.personView;
}

-(void)changeImage{
 
    UIAlertController *alertController;
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
      
        /*支持相机*/
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择来源：" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相机", @"本地相册",nil];
        [alert show];
        alertController = [UIAlertController alertControllerWithTitle:@"请选择来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *pickerController =[[UIImagePickerController alloc]init];
            pickerController.allowsEditing = YES;
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerController.delegate = self;
            [self presentViewController:pickerController animated:YES completion:nil];
            }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                pickerController.delegate = self;
                pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickerController.allowsEditing = YES;
                [self presentViewController:pickerController animated:YES completion:nil];
            }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                return ;
            }]];
        
    }
    else{
    alertController = [UIAlertController alertControllerWithTitle:@"请选择文件来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *locationAction = [UIAlertAction actionWithTitle:@"本地图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:locationAction];
    [alertController addAction:cancleAction];
    [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UIImagePickerController *pickerController =[[UIImagePickerController alloc]init];
        pickerController.allowsEditing = YES;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        [self presentViewController:pickerController animated:YES completion:nil];
    }
 
    else if(buttonIndex == 2){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];


    }
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       UITableViewCell* cell = [[UITableViewCell alloc]init];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        cell.textLabel.text = arrayList[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
   
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"hahah  %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"session"]);
    NSString *session =  [[NSUserDefaults standardUserDefaults]objectForKey:@"session"];
    if (indexPath.row!=3&& (session.length == 0)) {
        LoginController *LoginV = [[LoginController alloc]init];
        [self .navigationController pushViewController:LoginV animated:YES];
        self.navigationController.hidesBottomBarWhenPushed = YES;
    }
    else if(indexPath.row == 3){
        RootRankViewController *rootRankVc =[[RootRankViewController alloc]init];
        self.navigationController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rootRankVc animated:YES];
        
    }

    else{
        if (indexPath.row == 0) {
        LendViewController *lendVc = [[LendViewController alloc]init];
        self.navigationController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lendVc animated:YES];
        }
        else if(indexPath.row == 1){
            FavoriteViewController *favoriteVc = [[FavoriteViewController alloc]init];
            self.navigationController.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:favoriteVc animated:YES];
        }
        else if(indexPath.row == 2){
            HistoryViewController *historyVc = [[HistoryViewController alloc]init];
            self.navigationController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:historyVc animated:YES];
        }

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.personView.ImageButton setImage:image forState:UIControlStateNormal];
    [self saveImage:image withName:@"currenImage.png"];
}
/*将图片保存进沙盒*/
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
-(void)loginorChange:(UIButton *)sender{
    NSLog(@"哈哈哈哈%ld",sender.tag);
    if (sender.tag ==0) {
        [self.navigationController pushViewController:[[LoginController alloc]init] animated:YES];
        self.navigationController.hidesBottomBarWhenPushed = YES;
    }
    else{
        [self changeImage];
    }
}
@end


