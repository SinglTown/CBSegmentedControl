//
//  CBSegmentedControl.m
//  CBSegmentedControl
//
//  Created by 赵传保 on 2018/1/8.
//  Copyright © 2018年 赵传保. All rights reserved.
//

#import "CBSegmentedControl.h"
#import "UIView+Frame.h"
@interface CBSegmentedControl()

/**
 移动的view
 **/
@property (nonatomic,strong)UIView *backView;
/**
 承载最上层的label的view
 **/
@property (nonatomic,strong)UIView *backLabelTopView;


@end

@implementation CBSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedItem = 0;
        [self setAllViews];
    }
    return self;
}
-(void)setAllViews
{
    if (self.titles.count == 0) {
        return;
    }
    
    CGFloat width = self.frame.size.width/self.titles.count;
    CGFloat height = self.frame.size.height;
    
    //背景色
    self.backgroundColor = self.segBackColor ? self.segBackColor : [UIColor whiteColor];
    self.layer.cornerRadius =  height/2;
    self.clipsToBounds = YES;
    
    if (self.isShowBorder) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = (self.selectedBackColor ? self.selectedBackColor : [UIColor grayColor]).CGColor;
    }
    
    //添加最底部的label
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(width*i, 0, width, height);
        label.userInteractionEnabled = YES;
        label.font = [UIFont systemFontOfSize:14];
        label.tag = i;
        label.text = self.titles[i];
        label.backgroundColor = [UIColor clearColor];
        label.textColor =  self.nonSelectedColor ? self.nonSelectedColor : [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedLabel:)];
        [label addGestureRecognizer:tap];
        [self addSubview:label];
    }
    
    //移动的背景
    self.backView.frame = CGRectMake(self.selectedItem*width, 0, width, height);
    self.backView.backgroundColor = self.selectedBackColor ? self.selectedBackColor : [UIColor grayColor];
    self.backView.layer.cornerRadius = height/2;
    self.backView.clipsToBounds = YES;
    [self addSubview:self.backView];
    
    //再添加一层view,放置未选中状态下的label
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(-self.selectedItem*width, 0, width, height)];
    topBackView.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:topBackView];
    self.backLabelTopView = topBackView;
    
    for (int i = 0;i<self.titles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.userInteractionEnabled = YES;
        label.text = self.titles[i];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = self.selectedTextColor ? self.selectedTextColor : [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.frame = CGRectMake(width*i,0, width, height);
        label.textAlignment = NSTextAlignmentCenter;
        [topBackView addSubview:label];
    }
}
-(void)selectedLabel:(UITapGestureRecognizer *)tap
{
    CGFloat width = self.frame.size.width/self.titles.count;
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.left = tap.view.tag*width;
        self.backLabelTopView.left = -tap.view.tag*width;
        [self.backView layoutIfNeeded];
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControlSeletedIndex:)]) {
        [self.delegate segmentedControlSeletedIndex:tap.view.tag];
    }
}
-(void)setSelectedItem:(NSInteger)selectedItem
{
    _selectedItem = selectedItem;
    
    if (self.titles && self.titles.count > 0) {
        CGFloat width = self.frame.size.width/self.titles.count;
        self.backView.left = selectedItem*width;
        self.backLabelTopView.left = -selectedItem*width;
        [self.backView layoutIfNeeded];
    }
}
-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    if (titles && titles.count > 0) {
        [self removeFromSuperview];
        [self setAllViews];
    }
}
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
    }
    return _backView;
}
@end
