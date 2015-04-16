//
//  UIView+Util.m
//  七巧板
//
//  Created by Wang on 14-1-13.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)
-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)point{
    CGRect frame = self.frame;
    self.frame = CGRectMake(point.x, point.y, frame.size.width, frame.size.height);
}
-(CGSize)size{
    return self.frame.size;
}
-(void)setSize:(CGSize)_size{
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, _size.width, _size.height);
}
-(CGFloat)width{
    return self.size.width;
}
-(void)setWidth:(CGFloat)width{
    [self setSize:CGSizeMake(width, self.size.height)];
}
-(CGFloat)height{
    return self.size.height;
}
-(void)setHeight:(CGFloat)height{
    [self setSize:CGSizeMake(self.size.width, height)];
}
-(CGFloat)x{
    return self.origin.x;
}
-(void)setX:(CGFloat)x{
    [self  setOrigin:CGPointMake(x, self.origin.y)];
}
-(CGFloat)y{
    return self.origin.y;
}
-(void)setY:(CGFloat)y{
    [self setOrigin:CGPointMake(self.origin.x, y)];
}
-(CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}
-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}
@end
