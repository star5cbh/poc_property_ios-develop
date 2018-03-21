//
//  BaseTableView.m
//  Webet
//
//  Created by chenbaohui on 2016/12/14.
//  Copyright © 2016年 peersafe_webet. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.contentInset = UIEdgeInsetsMake(0,0,0,0);
            self.scrollIndicatorInsets = self.contentInset;
        }else{
        }
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.tableFooterView = [UIView new];
    }
    return self;
}

@end
