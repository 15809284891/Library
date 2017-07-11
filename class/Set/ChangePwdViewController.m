//
//  ChangePwdViewController.m
//  图书管理
//
//  Created by shixihao on 16/7/26.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define StatusHeight  [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavigationBarHeight  self.navigationController.navigationBar.bounds.size.height
#define Viewwidth self.view.bounds.size.width
#define Viewheight self.view.bounds.size.height
#define tabbarHeight  self.tabBarController.tabBar.bounds.size.height
#import "ChangePwdViewController.h"
#import "ChangePwdView.h"
@interface ChangePwdViewController ()
@property (nonatomic) ChangePwdView *changePwdView;
@end

@implementation ChangePwdViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 100, 44)];
        titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
        titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"修改密码";  //设置标题
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ChangePwdView *changePwdView =[[ChangePwdView alloc]init];
    changePwdView.frame = CGRectMake(0,NavigationBarHeight+StatusHeight, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:changePwdView];
    changePwdView.userNameField.delegate = self;
    changePwdView.oldPwdField.delegate = self;
    changePwdView.changedPwdField.delegate = self;
    changePwdView.surePwdField.delegate = self;
    NSString *serviceName = @"cn.lixue";
    NSArray *temp = [[SSKeychain accountsForService:serviceName]lastObject];
    NSString *userName = [temp valueForKey:@"acct"];
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"session"]!=NULL) {
        changePwdView.userNameField.text = userName;
//    }
    
    self.changePwdView = changePwdView;
    self.view.backgroundColor  = [UIColor  whiteColor];

    [self.changePwdView.changeBT addTarget:self action:@selector(ChangePwdAction) forControlEvents:UIControlEventTouchUpInside];
   }
-(void)ChangePwdAction{
//    APIClass *changePwdAPI = [[APIClass alloc]init];
//    [changePwdAPI RequestChangePwdSatatus:self.changePwdView.oldPwdField.text :self.changePwdView.changedPwdField.text :self.changePwdView.surePwdField.text :^(id isChanged) {
//        if ([isChanged isEqualToString:@"修改成功"]) {
//            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
////                [self presentViewController:[[TabbarViewController alloc]init] animated:YES completion:nil];
//            });
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:isChanged];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//        }
//    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
       return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.changePwdView.userNameField) {
        [self.changePwdView.userNameField becomeFirstResponder];
        [self.changePwdView.oldPwdField resignFirstResponder];
        [self.changePwdView.changedPwdField resignFirstResponder];
        [self.changePwdView.surePwdField resignFirstResponder];
    }
    else if(textField == self.changePwdView.oldPwdField){
        [self.changePwdView.oldPwdField becomeFirstResponder];
        [self.changePwdView.userNameField resignFirstResponder];
        [self.changePwdView.changedPwdField resignFirstResponder];
        [self.changePwdView.surePwdField resignFirstResponder];
    }
    else if(textField == self.changePwdView.changedPwdField){
        [self.changePwdView.changedPwdField becomeFirstResponder];
        [self.changePwdView.userNameField resignFirstResponder];
        [self.changePwdView.oldPwdField resignFirstResponder];
        [self.changePwdView.surePwdField resignFirstResponder];
    }
    else if(textField == self.changePwdView.surePwdField){
        [self.changePwdView.surePwdField becomeFirstResponder];
        [self.changePwdView.userNameField resignFirstResponder];
        [self.changePwdView.oldPwdField resignFirstResponder];
        [self.changePwdView.changedPwdField resignFirstResponder];
    }

}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

@end
