//
//  ViewController.m
//  CBSegmentedControl
//
//  Created by 赵传保 on 2018/1/8.
//  Copyright © 2018年 赵传保. All rights reserved.
//

#import "ViewController.h"
#import "CBSegmentedControl.h"
@interface ViewController () <CBSegmentedControlDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    CBSegmentedControl *seg = [[CBSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    seg.center = CGPointMake(self.view.frame.size.width/2, 100);
    seg.segBackColor = [UIColor purpleColor];
    seg.selectedBackColor = [UIColor orangeColor];
    seg.nonSelectedColor = [UIColor yellowColor];
    seg.selectedTextColor = [UIColor redColor];
    seg.selectedItem = 1;
    seg.titles = @[@"男频",@"女频"];
    seg.delegate = self;
    [self.view addSubview:seg];
    
}
-(void)segmentedControlSeletedIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld个item",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
