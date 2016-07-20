//
//  ElevenDemoDetailViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/7/19.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "ElevenDemoDetailViewController.h"

@interface ElevenDemoDetailViewController ()

@property (copy, nonatomic) id backBlock;

@property (strong, nonatomic) UITextField *textField;

@end

@implementation ElevenDemoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 200, 100, 50);
    
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    textField.frame = CGRectMake(100, 300, 100, 50);
    self.textField = textField;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (void)buttonOnClick:(UIButton *)button {
    
    void(^myBackBlock)(NSString *backString, id info) = self.backBlock;
    if (myBackBlock) {
        if (self.textField.text.length > 0) {
            myBackBlock(self.textField.text, nil);

            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}




- (void)detalBackBlockValue:(void(^)(NSString *backString, id info))backBlock{
    
    if (backBlock) {
        self.backBlock = backBlock;
    }
}


@end
