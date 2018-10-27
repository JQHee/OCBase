//
//  NSString+check.m
//  elmsc
//
//  Created by MAC on 2017/1/5.
//  Copyright © 2017年 GFB Network Technology Co.,Ltd. All rights reserved.
//

#import "NSString+check.h"

@implementation NSString (check)

+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+ (BOOL)isValidAboutInputText:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger)number {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers;
    NSRange pointRange = [textField.text rangeOfString:@"."];
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) ){
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }else{
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] ){
        return NO;
    }
    short remain = number; //保留 number位小数
    NSString *tempStr = [textField.text stringByAppendingString:string];
    NSUInteger strlen = [tempStr length];
    if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
        if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
            return NO;
        }
        if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
            return NO;
        }
    }
    
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
        if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
            textField.text = string;
            return NO;
        }else{
            if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                if([string isEqualToString:@"0"]){
                    return NO;
                }
            }
        }
    }
    
    NSString *buffer;
    if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) ){
        return NO;
    }else{
        return YES;
    }
}

// 只保留后四位数字，其它位用星号替代
+ (NSString *) charcterWithStar:(NSString *) str {
    if (str.length <= 4) {
        return str;
    }
    NSMutableString *mutStr = [NSMutableString new];
    NSString *firstStr = [str substringWithRange:NSMakeRange(0,str.length - 4)];
    NSString *secondStr = [str substringWithRange:NSMakeRange(str.length - 4,4)];
    NSMutableString *starStr = [NSMutableString new];
    for (int i = 0; i <= firstStr.length - 1; i++) {
        [starStr appendString:@"*"];
    }
    firstStr = [firstStr stringByReplacingOccurrencesOfString:[firstStr substringWithRange:NSMakeRange(0,firstStr.length)]withString:starStr];
    [mutStr appendString:firstStr];
    [mutStr appendString:secondStr];
    return mutStr;
}

// 移除字符串中的所有空格
+ (NSString *) removeStrAllSpace:(NSString *)str {
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

+ (NSString *) addSpaceWithStr:(NSString *)str toStr:(NSString *) toStr length:(NSInteger) number {
    if (str.length <= number) {
        return str;
    }
    NSMutableString *subStr = [[NSMutableString alloc]initWithString:str];
    // 如果可以整除，最前面则不添加
    NSInteger index = (str.length / number - 1);
    for (int i = 0; i < index; i++) {
        // 开始追加字符
        [subStr insertString:toStr atIndex:(subStr.length - (i * (number + toStr.length) + number))];
    }
    return subStr;
}


@end
