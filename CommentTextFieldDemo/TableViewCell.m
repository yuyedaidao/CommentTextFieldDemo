//
//  TableViewCell.m
//  CommentTextFieldDemo
//
//  Created by Wang on 15/4/17.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)click:(id)sender {
    if(self.clickBlock){
        self.clickBlock(sender);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
