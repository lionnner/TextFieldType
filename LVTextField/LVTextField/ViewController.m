//
//  ViewController.m
//  LVTextField
//
//  Created by lvjialin on 2016/9/23.
//  Copyright © 2016年 lionnner. All rights reserved.
//

#import "ViewController.h"
#import "LVTextField.h"

@interface ViewController ()
{
    LVTextField *_textField;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField = [[LVTextField alloc] initWithFrame:CGRectMake(10, 100, 300, 40) LVTextFieldType:LVTextFieldTypeMoney];
    _textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_textField];
    
    
    LVTextField *textField = [[LVTextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40) LVTextFieldType:LVTextFieldTypeCountNonZeroFront limit:10];
    textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:textField];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
