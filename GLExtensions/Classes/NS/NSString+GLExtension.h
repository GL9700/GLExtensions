//
//  NSString+GLExtension.h
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 快速格式化文字 stringWithFormat: */
#define SF(str, ...) [NSString stringWithFormat:str, ## __VA_ARGS__]

/// 是否为空
UIKIT_STATIC_INLINE BOOL isEmptyString(NSString *str)
{
    return (str == nil || str.length == 0 || [[str lowercaseString] isEqualToString:@"<null>"] || [str isEqual:[NSNull null]]);
}

@interface NSString (GLExtension)

/*
 * [NSCharacterSet controlCharacterSet];                 //控制符的字符集
 * [NSCharacterSet whitespaceCharacterSet];              //空格的字符集
 * [NSCharacterSet whitespaceAndNewlineCharacterSet];    //空格和换行符的字符集
 * [NSCharacterSet decimalDigitCharacterSet];            //十进制数字的字符集
 * [NSCharacterSet letterCharacterSet];                  //所有字母的字符集
 * [NSCharacterSet lowercaseLetterCharacterSet];         //小写字母的字符集
 * [NSCharacterSet uppercaseLetterCharacterSet];         //大写字母的字符集
 * [NSCharacterSet nonBaseCharacterSet];                 //非基础的字符集
 * [NSCharacterSet alphanumericCharacterSet];            //字母和数字的字符集
 * [NSCharacterSet decomposableCharacterSet];            //可分解
 * [NSCharacterSet illegalCharacterSet];                 //非法的字符集
 * [NSCharacterSet punctuationCharacterSet];             //标点的字符集
 * [NSCharacterSet capitalizedLetterCharacterSet];       //首字母大写的字符集
 * [NSCharacterSet symbolCharacterSet];                  //符号的字符集
 * [NSCharacterSet newlineCharacterSet];                 //换行符的字符集
 */
/// 是否包含字符集。(如果不包含，则返回nil，否则返回自身值)
- (NSString *)isContainsCharset:(NSCharacterSet *)charset;

/// 表情符号的判断。(如果不包含，则返回nil，否则返回自身值)
- (NSString *)isContainsEmoji;
- (BOOL)stringContainsEmoji API_DEPRECATED("use [<instance> containsEmoji]", ios(2.0,2.0));

/** 判断是不是九宫格拼音键盘 */
- (BOOL)isNineKeyBoard;

/// 包含中文字符。(如果不包含，则返回nil，否则返回自身值)
- (NSString *)isContainsChineseCharset;
- (BOOL)hasChinese API_DEPRECATED("use [<instance> isContainsChineseCharset]", ios(2.0,2.0));

/// 包含指定字符串, exact:完全匹配字符串
- (NSString *)isContainString:(NSString *)str exact:(BOOL)excatMatch;
- (BOOL)isContain:(NSString *)str API_DEPRECATED("use [<instance> isContainString:exact:]", ios(2.0,2.0));;


/// 匹配手机号
- (BOOL)isMatchPhone;
/// 匹配邮箱
- (BOOL)isMatchEmail;
/// 匹配WebURL地址
- (BOOL)isMatchRemoteURL;


/** 去除所有空格和回车 */
- (NSString *)trim;

/** URL 编码 */
- (NSString *)URLEncode;

/** URL 解码 */
- (NSString *)URLDecode;

/** 使用MD5编码 */
- (NSString *)md5;

/** 使用Base64编码 */
- (NSData *)base64Decode;

/** 使用正则获取内容 */
- (NSString *)stringForRegular:(NSString *)regular;

/*** 去掉html标签*/
- (NSString *)removeHtmlTag;

/** 计算字符串size */
- (CGSize)boundingRectWithWidth:(float)width Font:(UIFont *)font;
@end


/// 是否为手机号
UIKIT_STATIC_INLINE BOOL isPhoneNumber(NSString *str) API_DEPRECATED("use [<instance> isMatchPhone]", ios(2.0,2.0)){
    return [str isMatchPhone];
}

/// 是否为Email
UIKIT_STATIC_INLINE BOOL isEMail(NSString *str) API_DEPRECATED("use [<instance> isMatchEmail]", ios(2.0,2.0)){
    return [str isMatchEmail];
}
