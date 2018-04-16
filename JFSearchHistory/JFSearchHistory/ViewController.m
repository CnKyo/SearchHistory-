//
//  ViewController.m
//  JFSearchHistory
//
//  Created by 张建飞 on 2018/4/12.
//  Copyright © 2018年 JeffinZhang. All rights reserved.
//

#import "ViewController.h"
#import "JFSearchController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)pushSearchBtn:(id)sender {
    
    [self.navigationController pushViewController:[[JFSearchController alloc]init] animated:YES];
}


@end
