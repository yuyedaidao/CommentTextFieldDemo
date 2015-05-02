# CommentTextFieldDemo

##废话少数，先上图

![实例图](https://github.com/yuyedaidao/CommentTextFieldDemo/blob/master/2015-05-02%2016_07_27.gif)

##上代码

    [CommentTextField showWithComplelateBlcok:^(CommentTextField *view) {
      NSLog(@"str = %@",view.textField.text);
    }];
    
    [CommentTextField showWithUsername:@"小明" complelateBlcok:^(CommentTextField *view) {
      NSLog(@"str = %@",view.textField.text);
    }];
    
    [CommentTextField showWithScrollResign:NO alloweMoveInView:tableView flagView:clicedView complelateBlcok:^(CommentTextField      *view) {
            
    }];

*要想在UIScrollView上滑动即隐藏控件需要在UIScrollView的willDrag代理方法里实现CommentTextField的hide方法*
