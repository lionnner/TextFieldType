//
//  LVTextField.m
//  LVATextFiled
//
//  Created by lvjialin on 2016/9/23.
//  Copyright © 2016年 lionnner. All rights reserved.
//

#import "LVTextField.h"

@interface LVTextField ()
{
    LVTextFieldType _type;
    NSInteger _limit;
}
@end

@implementation LVTextField

- (instancetype)initWithFrame:(CGRect)frame LVTextFieldType:(LVTextFieldType)type limit:(NSInteger)limit
{
    self = [self initWithFrame:frame LVTextFieldType:type];
    if (self) {
        _limit = limit;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                    name:UITextFieldTextDidChangeNotification object:self];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame LVTextFieldType:(LVTextFieldType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        self.delegate = self;
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    switch (_type) {
        case LVTextFieldTypeNone:{
            return YES;
            break;
        }
        case LVTextFieldTypeCount:{
            NSScanner      *scanner    = [NSScanner scannerWithString:string];
            NSCharacterSet *numbers;
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            NSString *buffer;
            if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) ){
                return NO;
            }
            return YES;
            break;
        }
        case LVTextFieldTypeCountNonZeroFront:{
            NSScanner      *scanner    = [NSScanner scannerWithString:string];
            NSCharacterSet *numbers;
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            NSRange zeroRange = [textField.text rangeOfString:@"0"];
            if(zeroRange.length == 1 && zeroRange.location == 0){
                if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){
                    textField.text = string;
                }
                return NO;
            }
            NSString *buffer;
            if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) ){
                return NO;
            }
            return YES;
            break;
        }
        case LVTextFieldTypeMoney:{
            NSScanner      *scanner    = [NSScanner scannerWithString:string];
            NSCharacterSet *numbers;
            NSRange         pointRange = [textField.text rangeOfString:@"."];
            
            if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) ){
                numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            } else {
                numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
            }
            if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] ){
                return NO;
            }
            short remain = 2;
            NSString *tempStr = [textField.text stringByAppendingString:string];
            NSUInteger strlen = [tempStr length];
            if(pointRange.length > 0 && pointRange.location > 0){
                if([string isEqualToString:@"."]){
                    return NO;
                }
                if(strlen > 0 && (strlen - pointRange.location) > remain+1){
                    return NO;
                }
            }
            NSRange zeroRange = [textField.text rangeOfString:@"0"];
            if(zeroRange.length == 1 && zeroRange.location == 0){
                if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){
                    textField.text = string;
                    return NO;
                }else{
                    if(pointRange.length == 0 && pointRange.location > 0){
                        if([string isEqualToString:@"0"]){
                            return NO;
                        }
                    }
                }
            }
            NSString *buffer;
            if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) ){
                return NO;
            }
            return YES;
            break;
        }
        default:
            return YES;
            break;
    }
}

-(void)textFiledEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > _limit)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:_limit];
            if (rangeIndex.length == 1){
                textField.text = [toBeString substringToIndex:_limit];
            } else {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, _limit)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
