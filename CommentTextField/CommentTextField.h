//
//  CommentTextField.h
//  贝果
//
//  Created by Wang on 14-3-18.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>



@class CommentTextField;
@interface UIViewController (CommentTextField)
@property(nonatomic,weak) CommentTextField *commentTextField;
@end


typedef void (^CompelateBlcok)(CommentTextField *commentTextField);

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

-(void)hide;

- (IBAction)comment:(id)sender;
@property (copy,nonatomic) CompelateBlcok compelateBlock;

+(instancetype)showWithComplelateBlcok:(CompelateBlcok)compelateBlock;
+(instancetype)showWithUsername:(NSString *)username complelateBlcok:(CompelateBlcok)compelateBlock;

+(instancetype)showWithScrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView complelateBlcok:(CompelateBlcok)compelateBlock;
+(instancetype)showWithScrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView username:(NSString *)username complelateBlcok:(CompelateBlcok)compelateBlock;

+(instancetype)showWithScrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView topPadding:(CGFloat)topPadding complelateBlcok:(CompelateBlcok)compelateBlock;
+(instancetype)showWithScrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView username:(NSString *)username topPadding:(CGFloat)topPadding complelateBlcok:(CompelateBlcok)compelateBlock;

@end
