//
//  RACLoginViewController.m
//  MVVMDemo
//
//  Created by chenjiangchuan on 2017/2/17.
//  Copyright © 2017年 chenjiangchuan. All rights reserved.
//

#import "RACLoginViewController.h"
#import "RACJCViewModel.h"

@interface RACLoginViewController ()

/** ViewModel */
@property (nonatomic, strong) RACJCViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation RACLoginViewController

#pragma mark - Life Circle

- (id)initWithRouterParams:(NSDictionary *)params {
    if ((self = [self initWithNibName:nil bundle:nil])) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewModel];
}

#pragma mark - Private Methods

- (void)setupViewModel {
    
    // 测试帐号：18170957509， 密码：123456
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = self.viewModel.validLoginSignal;
    
    @weakify(self);
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.loginCommand execute:nil];
    }];
}

#pragma mark - Lazy Initialization

- (RACJCViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RACJCViewModel alloc] init];
    }
    return _viewModel;
}

@end
