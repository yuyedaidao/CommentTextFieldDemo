//
//  CommentTextField.h
//  贝果
//
//  Created by Wang on 14-3-18.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CommentTextField;
//@interface UIScrollView (CommentTextField)
//@property(nonatomic,weak) CommentTextField *commentTextField;
//@end


typedef void (^CompelateBlcok)(CommentTextField *view);

@interface CommentTextField : UIView<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UIView *textFieldView;
@property (retain, nonatomic) IBOutlet UITextField *textField;
@property (assign,nonatomic) NSInteger articleId;
@property (nonatomic,assign) BOOL shouldScrollResign;
@property (nonatomic,weak) UIView *moveView;
/**
 * 为了避免某些视图被键盘遮挡，需要让某视图移动到键盘的上方，这个视图用flagView标记
 */
@property (nonatomic,weak) UIView *flagView;
//@property (nonatomic,weak) 
-(void)hide;

- (IBAction)comment:(id)sender;
@property (copy,nonatomic) CompelateBlcok compelateBlock;

+(instancetype)showInView:(UIView *)view complelateBlcok:(CompelateBlcok)compelateBlock;
+(instancetype)showInView:(UIView *)view scrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView complelateBlcok:(CompelateBlcok)compelateBlock;
+(instancetype)showInView:(UIView *)view username:(NSString *)user complelateBlcok:(CompelateBlcok)compelateBlock;
+(instancetype)showInView:(UIView *)view scrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView username:(NSString *)user complelateBlcok:(CompelateBlcok)compelateBlock;



@end
