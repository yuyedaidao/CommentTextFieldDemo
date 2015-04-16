//
//  CommentTextField.h
//  贝果
//
//  Created by Wang on 14-3-18.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentTextField;
typedef void (^CompelateBlcok)(CommentTextField *view);

@interface CommentTextField : UIView<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UIView *textFieldView;
@property (retain, nonatomic) IBOutlet UITextField *textField;
@property (retain, nonatomic) IBOutlet UILabel *textLab;
@property (assign,nonatomic) NSInteger articleId;
- (IBAction)comment:(id)sender;
@property (copy,nonatomic) CompelateBlcok compelateBlock;
+(void)showInView:(UIView *)view complelateBlcok:(CompelateBlcok)compelateBlock;
+(void)showInView:(UIView *)view username:(NSString *)user complelateBlcok:(CompelateBlcok)compelateBlock;
@end
