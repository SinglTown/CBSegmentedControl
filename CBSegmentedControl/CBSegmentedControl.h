//
//  CBSegmentedControl.h
//  CBSegmentedControl
//
//  Created by 赵传保 on 2018/1/8.
//  Copyright © 2018年 赵传保. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBSegmentedControlDelegate <NSObject>

-(void)segmentedControlSeletedIndex:(NSInteger)index;

@end

@interface CBSegmentedControl : UIView

@property (nonatomic,weak)id<CBSegmentedControlDelegate> delegate;

/**
 title(设置完所有执行值之后再设置此属性)
 **/
@property (nonatomic,strong)NSArray *titles;


/**
 整个segment的背景色,相当于选中的item颜色
 **/
@property (nonatomic,strong)UIColor *segBackColor;
/**
 选中item的背景色
 **/
@property (nonatomic,strong)UIColor *selectedBackColor;
/**
 选中item的文字颜色
 **/
@property (nonatomic,strong)UIColor *selectedTextColor;
/**
 未选中item的文字颜色
 **/
@property (nonatomic,strong)UIColor *nonSelectedColor;
/**
 是否添加边框
 **/
@property (nonatomic,assign)BOOL isShowBorder;

@end
