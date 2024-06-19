//
//  NSString+GLExtension.m
//  GLExtensions_Example
//
//  Created by liguoliang on 2018/9/6.
//  Copyright © 2018年 liguoliang. All rights reserved.
//

#import <GLExtensions/NSString+GLExtension.h>
#import <CommonCrypto/CommonDigest.h>

#define regPhone @"^(1[3|4|5|6|7|8|9])\\d{9}$"
#define regEmail @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define regURL   @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
#define regEmoji @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
#define kURLEncodeCharters "?!@#$^&%*+,:;='\"`<>()[]{}/\\| "

@implementation NSString (GLExtension)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (BOOL)isMatchRemoteURL {
    if(!isEmptyString(self)) {
        NSString *phoneRegex = regURL;
        NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        return [phonePredicate evaluateWithObject:self];
    }
    return NO;
}

- (BOOL)isMatchPhone {
    if(!isEmptyString(self)) {
        NSString *phoneRegex = regPhone;
        NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        return [phonePredicate evaluateWithObject:self];
    }
    return NO;
}

- (BOOL)isMatchEmail {
    if(!isEmptyString(self)) {
        NSString *emailRegex = regEmail;
        NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
        return [emailPredicate evaluateWithObject:self];
    }
    return NO;
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)URLEncode { // mk_ prefix prevents a clash with a private api
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, nil, CFSTR(kURLEncodeCharters), kCFStringEncodingUTF8);
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)encodedCFString];
    if (!encodedString) encodedString = @"";
    return encodedString;
}

- (NSString *)URLDecode {
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (__bridge CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    if (decodedCFString) {
        NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)decodedCFString];
        if (decodedString) {
            decodedString = [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
            decodedString = [decodedString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
            return decodedString;
        }
    }
    return @"";
}
#pragma clang diagnostic pop

+ (NSString *)stringOfRandomLength:(NSInteger)length letters:(id)letters {
    NSMutableString *randomString = [NSMutableString string];
    id letterList = letters;
    if(letterList == nil) {
        letterList = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    }
    if([letterList isKindOfClass:[NSString class]]) {
        for (int i = 0; i < length; i++) {
            [randomString appendFormat: @"%C", [letterList characterAtIndex: arc4random_uniform((u_int32_t)[letterList length])]];
        }
    }
    else if([letterList isKindOfClass:[NSArray class]]) {
        for (int i = 0; i < length; i++) {
//            [randomString appendFormat: @"%C", [letterList characterAtIndex: arc4random_uniform((u_int32_t)[letterList length])]];
            NSInteger idx = arc4random() % ((NSArray *)letterList).count;
            [randomString appendString:((NSArray *)letterList)[idx]];
        }
    }
    return randomString;
}

- (BOOL)isContain:(NSString *)str {
    if([self isContainString:str exact:YES]) {
        return YES;
    }
    return NO;
}
- (NSString *)isContainString:(NSString *)str exact:(BOOL)excatMatch {
    if(excatMatch == YES) {
        NSRange range = [self rangeOfString:str];
        if(range.location == NSNotFound){
            return nil;
        }
        return self;
    }else{
        return [self isContainsCharset:[NSCharacterSet characterSetWithCharactersInString:str]];
    }
}

- (BOOL)hasChinese {
    return [self isContainsChineseCharset]!=nil;
}
- (NSString *)isContainsChineseCharset {
    for (int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return self;
        }
    }
    return nil;
}

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
    ];
}

- (NSData *)base64Decode {
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[4];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    ixtext = 0;
    tempcstring = (const unsigned char *)[self UTF8String];
    lentext = [self length];
    theData = [NSMutableData dataWithCapacity:lentext];
    ixinbuf = 0;
    while (true) {
        if (ixtext >= lentext) {
            break;
        }
        ch = tempcstring [ixtext++];
        flignore = false;
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        }
        else if (ch == '+') {
            ch = 62;
        }
        else if (ch == '=') {
            flendtext = true;
        }
        else if (ch == '/') {
            ch = 63;
        }
        else {
            flignore = true;
        }
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                if ((ixinbuf == 1) || (ixinbuf == 2)) ctcharsinbuf = 1;
                else ctcharsinbuf = 2;
                ixinbuf = 3;
                flbreak = true;
            }
            inbuf [ixinbuf++] = ch;
            if (ixinbuf == 4) {
                ixinbuf = 0;
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes:&outbuf[i] length:1];
                }
            }
            if (flbreak) {
                break;
            }
        }
    }
    return theData;
}

- (NSString *)stringForRegular:(NSString *)regular {
    return [self itemForPattern:regular captureGroupIndex:0];
}

/** 使用正则获取全部匹配内容 */
- (NSArray<NSString *> *)resultsForRegular:(NSString *)regular {
    if (!regular) return nil;
    NSError *error = nil;
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:regular options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        NSRange range = NSMakeRange(0, [self length]);
        NSArray<NSTextCheckingResult *> * rls = [regx matchesInString:self options:NSMatchingReportCompletion range:range];
        if(rls && rls.count>0) {
            NSMutableArray<NSString *> *results = [NSMutableArray array];
            for(NSTextCheckingResult *cr in rls) {
                [results addObject:[self substringWithRange:cr.range]];
            }
            return results;
        }
    }
    return nil;
}

/** 使用正则替换内容 */
- (NSString *)stringByReplacingRegular:(NSString *)regular toTemplate:(NSString *)t {
    if (!regular) return nil;
    NSError *error = nil;
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:regular options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        NSRange range = NSMakeRange(0, [self length]);
        return [regx stringByReplacingMatchesInString:self options:0 range:range withTemplate:t];
    }
    return self;
}

- (NSString *)itemForPattern:(NSString *)pattern captureGroupIndex:(NSUInteger)index {
    if (!pattern) return nil;
    NSError *error = nil;
    NSRegularExpression *regx = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        NSRange searchRange = NSMakeRange(0, [self length]);
        NSTextCheckingResult *result = [regx firstMatchInString:self options:NSMatchingReportCompletion range:searchRange];
        if (result) {
            NSRange groupRange = [result rangeAtIndex:index];
            NSString *match = [self substringWithRange:groupRange];
            return match;
        }
    }
    return nil;
}

/** 表情符号的判断 */

- (NSString *)isContainsEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        }
        else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        }
        else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            }
            else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            }
            else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            }
            else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            }
            else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    if (!returnValue) {//限制第三方键盘的表情
        NSString *pattern = regEmoji;
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
        returnValue = [pred evaluateWithObject:self];
    }
    if(returnValue){
        return self;
    }
    return nil;
}
- (BOOL)stringContainsEmoji {
    return [self isContainsEmoji]!=nil;
}

/** 判断是不是九宫格拼音键盘 */
- (BOOL)isNineKeyBoard {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    if (!([other rangeOfString:self].location != NSNotFound)) {
        return NO;
    }
    return YES;
}

/*** 去掉html标签*/
- (NSString *)removeHtmlTag {
    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n|&nbsp"
                                                                                      options:0
                                                                                        error:nil];
    NSString *string = [regularExpretion stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:@""];
    return string;
}

/** 计算字符串size */
- (CGSize)boundingRectWithWidth:(float)width Font:(UIFont *)font {
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(width, 0)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{ NSFontAttributeName: font }
                                          context:nil].size;
    return titleSize;
}
- (NSString *)isContainsCharset:(NSCharacterSet *)charset {
    NSRange range = [self rangeOfCharacterFromSet:charset];
    if(range.location < self.length) {
        return self;
    }else{
        return nil;
    }
}
@end
