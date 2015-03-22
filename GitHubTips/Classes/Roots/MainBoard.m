//
//  MainBoard.m
//  HealthTip
//
//  Created by Yorke on 14/12/8.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "MainBoard.h"
#import "MainViewModel.h"
#import "WTMainCell.h"

@interface MainBoard ()<UITableViewDataSource,UITableViewDelegate>{
    
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MainBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setHidesBarsOnSwipe:YES];
    [self.view addGestureRecognizer:self.navigationController.barHideOnSwipeGestureRecognizer];
    
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.viewModel.active = YES;
}

- (void)initView{
    [super initView];
    self.title = @"MainBoard";
    [self.view addSubview:self.tableView];
    [self setupLeftMenuButton];
}

- (void)initData{
    [super initData];
    self.viewModel = [[MainViewModel alloc]init];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfItemsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.viewModel titleForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"WTMainCell";
    WTMainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if(!cell){
        cell = (WTMainCell *)[[[NSBundle mainBundle]loadNibNamed:@"WTMainCell" owner:self options:nil]lastObject];
    }
    
    [cell setContent:[self.viewModel titleAtIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
