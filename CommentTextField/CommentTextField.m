//
//  CommentTextField.m
//  贝果
//
//  Created by Wang on 14-3-18.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "CommentTextField.h"
#import "UIView+Util.h"
#import <objc/runtime.h>

static CGFloat const padding = 10;
static CGFloat const height_toolBar = 41.0f;


@interface CommentTextField ()
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
/**
 *  目标视图与键盘边缘的距离
 */
@property (nonatomic,assign) CGFloat topPadding;
//@property (assign, nonatomic) 
@end


@implementation CommentTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(instancetype)showWithComplelateBlcok:(CompelateBlcok)compelateBlock{
    return  [self showWithScrollResign:NO alloweMoveInView:nil flagView:nil complelateBlcok:compelateBlock];
}
+(instancetype)showWithScrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView complelateBlcok:(CompelateBlcok)compelateBlock{
    
    return [self showWithScrollResign:resign alloweMoveInView:moveView flagView:flagView topPadding:0 complelateBlcok:compelateBlock];
}
+(instancetype)showWithScrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView topPadding:(CGFloat)topPadding complelateBlcok:(CompelateBlcok)compelateBlock{
    return [self showWithScrollResign:resign alloweMoveInView:moveView flagView:flagView username:nil topPadding:topPadding complelateBlcok:compelateBlock];
}
+(instancetype)showWithUsername:(NSString *)user complelateBlcok:(CompelateBlcok)compelateBlock{
    
    return [self showWithScrollResign:NO alloweMoveInView:nil flagView:nil username:user complelateBlcok:compelateBlock];
}

+(instancetype)showWithScrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView username:(NSString *)username topPadding:(CGFloat)topPadding complelateBlcok:(CompelateBlcok)compelateBlock{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CommentTextField *field = [[[NSBundle mainBundle] loadNibNamed:@"CommentTextField" owner:self options:nil] lastObject];
    field.frame = window.bounds;
    field.shouldScrollResign = resign;
    field.moveView = moveView;
    field.flagView = flagView;
//    field.sendButton.x = field.width - field.sendButton.width - padding;
    field.contentTF.width = field.width - padding*2;
    field.contentTF.x = padding;
    field.topPadding = topPadding;
    [window addSubview:field];
    field.compelateBlock = compelateBlock;
    [field.textField becomeFirstResponder];
    if(username){
        field.textField.placeholder = [NSString stringWithFormat:@"回复%@", username];
    }else{
        field.textField.placeholder = @"评论";
    }
    
    return field;

}
+(instancetype)showWithScrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView username:(NSString *)username complelateBlcok:(CompelateBlcok)compelateBlock{
    return [self showWithScrollResign:resign alloweMoveInView:moveView flagView:flagView username:username topPadding:0 complelateBlcok:compelateBlock];
}
-(void)awakeFromNib{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self addGestureRecognizer:tap];
    
    self.textFieldView.y = self.height;
    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
}
-(void)keyboardWillShow:(NSNotification *)notification{
    CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = CGRectGetHeight(rect)+height_toolBar;
    if(self.shouldScrollResign){
        self.frame = CGRectMake(self.x, self.superview.height - height, self.width, CGRectGetHeight(rect)+height_toolBar);
        self.textFieldView.frame = self.bounds;
    }
    if(self.moveView && self.flagView){
        //计算flag在self.superView中的位置看是否被键盘遮挡
        CGRect flagRect = [self.flagView.superview convertRect:self.flagView.frame toView:nil];
        if(CGRectGetMaxY(flagRect) > self.y){//说明被遮挡了
            self.moveView.transform = CGAffineTransformMakeTranslation(0, -(CGRectGetMaxY(flagRect) - self.y + self.topPadding));
        }
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if(self.shouldScrollResign){
        self.textFieldView.y = 0;
    }else{
        self.textFieldView.y = self.superview.height - height;
    }
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.3f animations:^{
        self.y = self.superview.height;
        if(self.moveView){
            self.moveView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)hideKeyboard:(UIGestureRecognizer *)gesture{
    [self.textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(self.compelateBlock){
        self.compelateBlock(self);
    }
    return YES;
}
-(void)hide{
    [self.textField resignFirstResponder];
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
- (IBAction)comment:(id)sender{
    if(self.compelateBlock){
        self.compelateBlock(self);
    }
    [self hideKeyboard:nil];
}

@end
