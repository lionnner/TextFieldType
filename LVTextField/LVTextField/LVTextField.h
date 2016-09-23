//
//  LVTextField.h
//  LVATextFiled
//
//  Created by lvjialin on 2016/9/23.
//  Copyright © 2016年 lionnner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LVTextFieldType) {
    LVTextFieldTypeNone, //不限制
    LVTextFieldTypeCount, //数量类 可以0在首位
    LVTextFieldTypeCountNonZeroFront, //数量类 非0开头(可以单0)
    LVTextFieldTypeMoney, // 金额类 默认小数点后保留2位
};

@interface LVTextField : UITextField<UITextFieldDelegate>

- (instancetype)initWithFrame:(CGRect)frame LVTextFieldType:(LVTextFieldType)type;

- (instancetype)initWithFrame:(CGRect)frame LVTextFieldType:(LVTextFieldType)type limit:(NSInteger)limit;

@end
