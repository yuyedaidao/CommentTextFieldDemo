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


static char YQCommentTextField;

//@implementation UIScrollView (CommentTextField)
//-(void)setCommentTextField:(CommentTextField *)commentTextField{
//    [self willChangeValueForKey:@"YQCommentTextField"];
//    objc_setAssociatedObject(self, &YQCommentTextField,
//                             commentTextField,
//                             OBJC_ASSOCIATION_ASSIGN);
//    [self didChangeValueForKey:@"YQCommentTextField"];
//}
//-(CommentTextField *)commentTextField{
//    
//    return  objc_getAssociatedObject(self, &YQCommentTextField);
//    
//}

//@end

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

+(instancetype)showInView:(UIView *)view complelateBlcok:(CompelateBlcok)compelateBlock{
    return  [self showInView:view scrollResign:NO alloweMoveInView:nil flagView:nil complelateBlcok:compelateBlock];
}
+(instancetype)showInView:(UIView *)view scrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView complelateBlcok:(CompelateBlcok)compelateBlock{
    CommentTextField *field = [[[NSBundle mainBundle] loadNibNamed:@"CommentTextField" owner:self options:nil] lastObject];
    field.shouldScrollResign = resign;
    field.moveView = moveView;
    field.flagView = flagView;
    field.frame = view.bounds;
    field.sendButton.x = field.width - field.sendButton.width - padding;
    field.contentTF.width = field.sendButton.x - padding*2;
    field.contentTF.x = padding;
    [view addSubview:field];
    field.compelateBlock = compelateBlock;
    [field.textField becomeFirstResponder];
    
    return field;
}
+(instancetype)showInView:(UIView *)view  username:(NSString *)user complelateBlcok:(CompelateBlcok)compelateBlock{
 
    return [self showInView:view scrollResign:NO alloweMoveInView:nil flagView:nil username:user complelateBlcok:compelateBlock];
}
+(instancetype)showInView:(UIView *)view scrollResign:(BOOL)resign alloweMoveInView:(UIView *)moveView flagView:(UIView *)flagView username:(NSString *)user complelateBlcok:(CompelateBlcok)compelateBlock{
    CommentTextField *field = [[[NSBundle mainBundle] loadNibNamed:@"CommentTextField" owner:self options:nil] lastObject];
    field.frame = view.bounds;
    field.shouldScrollResign = resign;
    field.moveView = moveView;
    field.flagView = flagView;
    field.sendButton.x = field.width - field.sendButton.width - padding;
    field.contentTF.width = field.sendButton.x - padding*2;
    field.contentTF.x = padding;
    [view addSubview:field];
    field.compelateBlock = compelateBlock;
    [field.textField becomeFirstResponder];
    field.textField.placeholder = [NSString stringWithFormat:@"回复%@", user];
    return field;
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
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
}
-(void)keyboardWillShow:(NSNotification *)notification{
    CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = CGRectGetHeight(rect)+height_toolBar;
    if(self.shouldScrollResign){
        self.frame = CGRectMake(self.x, self.superview.height - height, self.width, CGRectGetHeight(rect)+height_toolBar);
        self.textFieldView.frame = self.bounds;
    }
//    if(self.moveView && self.flagView){
//        //计算flag在self.superView中的位置看是否被键盘遮挡
//        CGRect flagRect = [self.flagView convertRect:self.flagView.frame toView:self.superview];
//        NSLog(@"flagRect = %@",NSStringFromCGRect(flagRect));
//        
//        NSLog(@" 1=== %lf   2 === %lf",flagRect.origin.y + flagRect.size.height,self.y);
//        if(CGRectGetMaxY(flagRect) > self.y){//说明被遮挡了
//            NSLog(@"调整位置了哟");
//           
//            if([self.moveView isKindOfClass:[UIScrollView class]]){
//                NSLog(@"调整位置");
//                UIScrollView *scrollView = (UIScrollView *)self.moveView;
//                 NSLog(@"offset =%@",NSStringFromCGPoint(scrollView.contentOffset));
//                CGPoint oldPoint = scrollView.contentOffset;
////                scrollView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(flagRect)-self.y, 0, 0, 0);
////                [scrollView setContentOffset:CGPointMake(oldPoint.x, oldPoint.y + (CGRectGetMaxY(flagRect)-self.y)) animated:YES];
//              
//            }
//        }
//    }
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
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)hideKeyboard:(UIGestureRecognizer *)gesture{
    [self.textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
