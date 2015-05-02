//
//  ViewController.m
//  CommentTextFieldDemo
//
//  Created by Wang on 15/4/16.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "ViewController.h"
#import "CommentTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showCommentTextField:(id)sender {
    [CommentTextField showWithComplelateBlcok:^(CommentTextField *view) {
        NSLog(@"str = %@",view.textField.text);
//        [view.textField resignFirstResponder];
    }];
}
- (IBAction)returnSomeOne:(id)sender {
    [CommentTextField showWithUsername:@"小明" complelateBlcok:^(CommentTextField *view) {
        NSLog(@"str = %@",view.textField.text);
//        [view.textField resignFirstResponder];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
