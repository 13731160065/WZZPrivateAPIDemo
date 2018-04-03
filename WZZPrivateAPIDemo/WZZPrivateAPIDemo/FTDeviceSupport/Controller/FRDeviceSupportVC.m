//
//  FRDeviceSupportVC.m
//  WZZPrivateAPIDemo
//
//  Created by 王泽众 on 2018/3/8.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "FRDeviceSupportVC.h"
#import <objc/runtime.h>

@interface FRDeviceSupportVC ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation FRDeviceSupportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray array];
    [self loadData];
    [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)loadData {
    NSBundle *b = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/FTServices.framework"];
    BOOL success = [b load];
    if (success) {
        Class aClass = NSClassFromString(@"FTDeviceSupport");
        id obj = [aClass performSelector:NSSelectorFromString(@"sharedInstance")];
        unsigned int count;
        objc_property_t * tArr = class_copyPropertyList(aClass, &count);
        for (int i = 0; i < count; i++) {
            objc_property_t tt = tArr[i];
            NSString * key = [NSString stringWithUTF8String:property_getName(tt)];//根据Ivar得到变量名字的字符串
            id aobj = [obj valueForKeyPath:key];
            [dataArr addObject:@{@"name":key, @"value":aobj?aobj:@""}];
        }
    }
    [_mainTableView reloadData];
}

- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSString * text = [NSString stringWithFormat:@"[%@]:%@", dataArr[indexPath.row][@"name"], dataArr[indexPath.row][@"value"]];
    [[cell textLabel] setText:text];
    [[cell textLabel] setAdjustsFontSizeToFitWidth:YES];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
