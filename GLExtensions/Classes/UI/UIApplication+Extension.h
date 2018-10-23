//
//  UIApplication+Extension.h
//  WCExtensions
//
//  Created by liguoliang on 2018/9/17.
//

#import <UIKit/UIKit.h>

/** app版本 */
UIKIT_STATIC_INLINE NSArray * releaseVersion() {
    NSString *str = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [str componentsSeparatedByString:@"."];
}

/** build版本 */
UIKIT_STATIC_INLINE NSArray * buildVersion() {
    NSString *str = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
    return [str componentsSeparatedByString:@"."];
}

/** application bundle id */
UIKIT_STATIC_INLINE NSString * bundleID() {
    return [[NSBundle mainBundle].infoDictionary objectForKey:(NSString *)kCFBundleIdentifierKey];
}

@interface UIApplication (Extension)

/**
* 暂时逻辑存在问题,修复后开放
  */
+ (BOOL)privacyAuthorizedForPhotoLibrary:(BOOL)needAlert;   //获得PhotoLibrary授权
+ (BOOL)privacyAuthorizedForCamera:(BOOL)needAlert;         //获得Camera授权
+ (BOOL)privacyAuthorizedForMicrophone:(BOOL)needAlert;     //已获得Microphone授权
+ (BOOL)privacyAuthorizedForAddressBook:(BOOL)needAlert;    //已获得AddressBook授权
+ (BOOL)privacyAuthorizedForRemoteNotification:(BOOL)needAlert; //已获得RemoteNotificationPush授权
+ (BOOL)privacyAuthorizedForCalendar:(BOOL)needAlert;   //已获得Calendar授权
+ (BOOL)privacyAuthorizedForLocationInUse:(BOOL)needAlert;  //已获得Location授权
+ (BOOL)privacyAuthorizedForLocationAlways:(BOOL)needAlert; //已获得Location授权

@end
