//
//  TableViewCell.h
//  CommentTextFieldDemo
//
//  Created by Wang on 15/4/17.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic,strong) void (^clickBlock)(UIView *view);
@end
