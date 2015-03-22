//
//  WTUIBoard.m
//  HealthTip
//
//  Created by Yorke on 14/11/30.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "WTUIBoard.h"
#import <MMDrawerController/MMDrawerBarButtonItem.h>

@interface WTUIBoard ()

@end

@implementation WTUIBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initView];
    
    // Do any additional setup after loading the view.
}

- (void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

- (void)setupRightQuestionButton{
    UIBarButtonItem *questionBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(questionAction:)];
    [self.navigationItem setRightBarButtonItem:questionBar animated:YES];
}

- (void)questionAction:(id)sender{
    
}

- (void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData{
    
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
