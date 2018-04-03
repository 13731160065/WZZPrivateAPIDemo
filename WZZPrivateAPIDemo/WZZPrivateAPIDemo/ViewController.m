//
//  ViewController.m
//  WZZPrivateAPIDemo
//
//  Created by 王泽众 on 2018/3/8.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "ViewController.h"
#import "FTServicesVC.h"
#import "FRDeviceSupportVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * dataArr;
}

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArr = [NSMutableArray array];
    [dataArr addObject:@"FTServices"];
    [dataArr addObject:@"FRDeviceSupport"];
    
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_mainTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * str = dataArr[indexPath.row];
    if ([str isEqualToString:@"FTServices"]) {
        FTServicesVC * avc = [[FTServicesVC alloc] init];
        [self presentViewController:avc animated:YES completion:nil];
    }
    if ([str isEqualToString:@"FRDeviceSupport"]) {
        FRDeviceSupportVC * vc = [[FRDeviceSupportVC alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

@end
