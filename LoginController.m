//
//  LoginController.m
//  图书管理
//
//  Created by shixihao on 16/7/19.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LoginController.h"
#import "LandModel.h"
#import <Security/Security.h>
#import "LXPlaceholderTextField.h"
#import "personViewController.h"
@interface LoginController()<UITextFieldDelegate>
{
    LXPlaceholderTextField *_userTF;
    LXPlaceholderTextField *_pwdTF;
    UIButton *_loginBT;
    UIView *_loginView;
    NSString *_session;
}
@property (nonatomic,strong)NSString *session;
@end
@implementation LoginController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"用户登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLoginView];
    [self setupContent];
}
-(void)setupLoginView{
    _loginView = [[UIView alloc]initWithFrame:CGRectMake(self.view.mj_w/7.0, self.view.mj_h*0.25, self.view.mj_w/7.0*5.0,self.view.mj_h*0.25)];
    [self.view addSubview:_loginView];
}
-(void)setupContent{
    _userTF = [[LXPlaceholderTextField alloc]initWithFrame:CGRectMake(0, 0, _loginView.mj_w, _loginView.mj_h*0.25)];
    _userTF.placeholder = @"请输入用户名";
    _userTF.delegate = self;
    [_loginView addSubview:_userTF];
    
    _pwdTF = [[LXPlaceholderTextField alloc]initWithFrame:CGRectMake(0, _userTF.mj_h, _loginView.mj_w, _userTF.mj_h)];
    _pwdTF.placeholder = @"密码";
    _pwdTF.delegate = self;
    _pwdTF.secureTextEntry = YES;
    [_loginView addSubview:_pwdTF];
    
    _loginBT = [[UIButton alloc]initWithFrame:CGRectMake(0, _userTF.mj_h*3.0, _userTF.mj_w,_loginView.mj_h*0.25)];
    _loginBT.imageView.contentMode = UIViewContentModeScaleToFill;
    [_loginBT setTitle:@"登录" forState: UIControlStateNormal];
    [_loginBT setTitle:@"登录中" forState: UIControlStateSelected];
    [_loginBT setBackgroundImage:[UIImage withBtnImage:[UIImage imageNamed:@"common_button_red"]] forState:UIControlStateNormal];
    [_loginView addSubview:_loginBT];
    [_loginBT addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}
-(void)login{
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:_loginBT animated:self];
    if (_userTF.text.length!=0&&_pwdTF.text.length!=0) {
        _loginBT.selected = YES;
    
        [_loginBT setTitle:@"登录中" forState: UIControlStateSelected];
        [_loginView setNeedsLayout];
        hud.xOffset = -50;
        hud.color = [UIColor clearColor];
        hud.frame = CGRectMake(0, 0, 30, 30);
        NSMutableString *url = [NSMutableString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/login"];
        NSDictionary *paramas = @{@"username":_userTF.text,@"password":_pwdTF.text};
        [[LXHTTPHelperClass shareInstanse]LXPOST:url parameters:paramas Value:^(id responseObject) {
            if ([responseObject[@"Detail"] isEqualToString:@"ACCOUNT_ERROR"]) {
                _loginBT.selected =NO;
                [hud removeFromSuperview];
                 MBProgressHUD *hud1 = [MBProgressHUD showMessage:@"用户名或密码错误"];
                [hud1 hide:YES afterDelay:2.0];
            }
            else{
            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"Detail"] forKey:@"session"];
            [SSKeychain setPassword:_pwdTF.text forService:ServiceName account:_userTF.text];
            [[NSNotificationCenter defaultCenter]postNotificationName:PINotifition object:nil];
            [hud removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
            }
        } Error:^(NSError *error) {
            _loginBT.selected =NO;
            [hud removeFromSuperview];
            MBProgressHUD *hud1 = [MBProgressHUD showMessage:@"登录失败"];
            [hud1 hide:YES afterDelay:2.0];
        }];

    }
    else if(_userTF.text.length == 0||_pwdTF.text.length == 0){
        _loginBT.selected =NO;
        [hud removeFromSuperview];
        MBProgressHUD *hud1 = [MBProgressHUD showMessage:@"请输入用户名或密码"];
        [hud1 hide:YES afterDelay:2.0];
    }

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    if (textField == _userTF) {
        [_pwdTF resignFirstResponder];
        [_userTF becomeFirstResponder];
    }
    else{
        [_userTF resignFirstResponder];
        [_pwdTF becomeFirstResponder];
    }

}

@end
