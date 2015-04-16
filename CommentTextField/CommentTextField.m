//
//  CommentTextField.m
//  贝果
//
//  Created by Wang on 14-3-18.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "CommentTextField.h"
#import "UIView+Util.h"

static CGFloat const padding = 10;

@interface CommentTextField ()
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
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
+(void)showInView:(UIView *)view complelateBlcok:(CompelateBlcok)compelateBlock{
    CommentTextField *field = [[[NSBundle mainBundle] loadNibNamed:@"CommentTextField" owner:self options:nil] lastObject];
    field.frame = view.bounds;
    field.sendButton.x = field.width - field.sendButton.width - padding;
    field.contentTF.width = field.sendButton.x - padding*2;
    field.contentTF.x = padding;
    [view addSubview:field];
    field.compelateBlock = compelateBlock;
    [field.textField becomeFirstResponder];
    field.textLab.hidden = YES;
}
+(void)showInView:(UIView *)view  username:(NSString *)user complelateBlcok:(CompelateBlcok)compelateBlock{
    CommentTextField *field = [[[NSBundle mainBundle] loadNibNamed:@"CommentTextField" owner:self options:nil] lastObject];
    field.frame = view.bounds;
    field.sendButton.x = field.width - field.sendButton.width - padding;
    field.contentTF.width = field.sendButton.x - padding*2;
    field.contentTF.x = padding;
    [view addSubview:field];
    field.compelateBlock = compelateBlock;
    [field.textField becomeFirstResponder];
    field.textLab.hidden = YES;
    field.textField.placeholder = [NSString stringWithFormat:@"回复%@", user];
//    field.textLab.text = [NSString stringWithFormat:@"回复%@", user];
}
-(void)awakeFromNib{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self addGestureRecognizer:tap];
//    [tap release];
    
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
    CGFloat y = self.height-CGRectGetHeight(rect)-41;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.textFieldView.y = y;
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.3f animations:^{
        self.textFieldView.y = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)hideKeyboard:(UIGestureRecognizer *)gesture{
    [self.textField resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if(textField.text.length>0){
//        self.textLab.hidden=YES;
//    }else{
//        self.textLab.hidden = NO;
//    }
//    
//    return YES;
//}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    Block_release(self.compelateBlock);
//    [_textFieldView release];
//    [_textField release];
//    [_textLab release];
//    [super dealloc];
}
- (IBAction)comment:(id)sender{
    if(self.compelateBlock){
        self.compelateBlock(self);
    }
    [self hideKeyboard:nil];
}

@end
