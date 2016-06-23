//
//  ViewController.m
//  UITextViewTest
//
//  Created by 雷传营 on 16/6/22.
//  Copyright © 2016年 Flying-Einstein. All rights reserved.
//

#import "ViewController.h"

#define kMainBoundsHeight   ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define kMainBoundsWidth    ([UIScreen mainScreen].bounds).size.width //屏幕的宽度
@interface ViewController ()<UITextViewDelegate>
{
    NSMutableArray * _dataArray;  //tableView数据存放数组
    
}

@property(nonatomic, retain) UITextView * contentTextView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 下面这一段代码，笔者就不费口舌了，读者应该都看的懂，就是创建一个外观类似于UITextField的UITextView
    self.contentTextView = [[UITextView alloc]initWithFrame:CGRectMake((kMainBoundsWidth-250)/2, kMainBoundsHeight/2-50, 250, 39)];
    self.contentTextView .layer.cornerRadius = 4;
    self.contentTextView .layer.masksToBounds = YES;
    self.contentTextView .delegate = self;
    self.contentTextView .layer.borderWidth = 1;
    self.contentTextView .font = [UIFont systemFontOfSize:14];
    self.contentTextView .layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    //加下面一句话的目的是，是为了调整光标的位置，让光标出现在UITextView的正中间
    self.contentTextView.textContainerInset = UIEdgeInsetsMake(10,0, 0, 0);
    [self.view addSubview:self.contentTextView ];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    CGRect frame = textView.frame;
    float height;
    if ([text isEqual:@""]) {
        
        if (![textView.text isEqualToString:@""]) {
            
            height = [ self heightForTextView:textView WithText:[textView.text substringToIndex:[textView.text length] - 1]];
            
        }else{
            
            height = [ self heightForTextView:textView WithText:textView.text];
        }
    }else{
        
            height = [self heightForTextView:textView WithText:[NSString stringWithFormat:@"%@%@",textView.text,text]];
    }

    frame.size.height = height;
    [UIView animateWithDuration:0.5 animations:^{
        
            textView.frame = frame;
        
        } completion:nil];
    
    return YES;
}

//计算评论框文字的高度
- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
//    float padding = 10.0;
    CGSize constraint = CGSizeMake(textView.contentSize.width, CGFLOAT_MAX);
    CGRect size = [strText boundingRectWithSize:constraint
                                             options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}
                                             context:nil];
    float textHeight = size.size.height + 22.0;
    return textHeight;
}

@end
