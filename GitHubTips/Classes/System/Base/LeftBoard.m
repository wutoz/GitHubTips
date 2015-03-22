//
//  LeftBoard.m
//  HealthTip
//
//  Created by Yorke on 15/2/28.
//  Copyright (c) 2015年 Yorke. All rights reserved.
//

#import "LeftBoard.h"
#import "CommonUtils.h"
#import "WTUserUtils.h"

@interface LeftBoard ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *tableData;

@end

@implementation LeftBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)initView{
    [super initView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"LeftBoard";
    [self.view addSubview:self.tableView];
}

- (void)initData{
    [super initData];
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSArray *)tableData{
    if(!_tableData){
        _tableData = @[@"首次登录",@"用户信息",@"关注列表",@"粉丝列表"];
    }
    return _tableData;
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIndentifier = @"tableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = self.tableData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [CommonUtils signInToServerUsingWebBrowserCompletion:nil failure:nil];
        }
            break;
        case 1:
        {
            [WTUserUtils fetchUserInfo];
        }
            break;
            case 2:
        {
            [WTUserUtils fetchFollowing];
        }
            break;
            case 3:
        {
            [WTUserUtils fetchFollowers];
        }
            break;
        default:
            break;
    }
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
