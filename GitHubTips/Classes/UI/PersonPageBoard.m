//
//  PersonPageBoard.m
//  GitHubTips
//
//  Created by Yorke on 15/3/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "PersonPageBoard.h"
#import "PersonViewModel.h"
#import <UIImageView+WebCache.h>

@interface PersonPageBoard ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *rawLoginLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;
@property (weak, nonatomic) IBOutlet UILabel *followersLab;
@property (weak, nonatomic) IBOutlet UILabel *followingLab;

@property (nonatomic, copy) NSURL *avatarURL;

@end

@implementation PersonPageBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    RAC(self.nameLab, text) = RACObserve(self.viewModel, name);
    RAC(self.rawLoginLab, text) = RACObserve(self.viewModel, rawLogin);
    RAC(self.companyLab, text) = RACObserve(self.viewModel, company);
    RAC(self.locationLab, text) = RACObserve(self.viewModel, location);
    RAC(self.emailLab, text) = RACObserve(self.viewModel, email);
    RAC(self.followersLab, text) = [RACObserve(self.viewModel, followers) map:^id(NSNumber *value) {
        return [NSString stringWithFormat:@"%@",value];
    }];
    RAC(self.followingLab, text) = [RACObserve(self.viewModel, following) map:^id(NSNumber *value) {
        return [NSString stringWithFormat:@"%@",value];
    }];
    RAC(self, avatarURL) = [RACObserve(self.viewModel, avatarURL) map:^id(NSURL *value) {
        [self.avatarImageView sd_setImageWithURL:value];
        return value;
    }];
    // Do any additional setup after loading the view.
}

- (void)updateView {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewModel.active = YES;
}

- (void)initView {
    [super initView];
}

- (void)initData {
    [super initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
