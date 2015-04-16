//
//  UIView+Util.h
//  七巧板
//
//  Created by Wang on 14-1-13.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)
-(CGPoint)origin;
-(void)setOrigin:(CGPoint)point;
-(CGSize)size;
-(void)setSize:(CGSize)size;
-(CGFloat)width;
-(void)setWidth:(CGFloat)width;
-(CGFloat)height;
-(void)setHeight:(CGFloat)height;
-(CGFloat)x;
-(void)setX:(CGFloat)x;
-(CGFloat)y;
-(void)setY:(CGFloat)y;
-(CGFloat)maxX;
-(CGFloat)maxY;
@end
