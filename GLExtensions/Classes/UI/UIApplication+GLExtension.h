//
//  UIApplication+GLExtension.h
//  GLExtensions
//
//  Created by liguoliang on 2018/9/17.
//

#import <UIKit/UIKit.h>

/// release版本 ** DEPRECATED : replaced by app_ver_market() **
UIKIT_STATIC_INLINE NSArray * releaseVersion(void)
{
    NSString *str = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [str componentsSeparatedByString:@"."];
}

/// build版本 ** DEPRECATED : replaced by app_ver_build() **
UIKIT_STATIC_INLINE NSArray * buildVersion(void)
{
    NSString *str = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
    return [str componentsSeparatedByString:@"."];
}

/// bundle Id ** DEPRECATED : replaced by app_bundle_Id() **
UIKIT_STATIC_INLINE NSString * bundleID(void)
{
    return [[NSBundle mainBundle].infoDictionary objectForKey:(NSString *)kCFBundleIdentifierKey];
}

/// App Release 版本
UIKIT_STATIC_INLINE NSArray * app_ver_market(void)
{
    return releaseVersion();
}

/// App Build 版本
UIKIT_STATIC_INLINE NSArray * app_ver_build(void)
{
    return buildVersion();
}

/// App名称
UIKIT_STATIC_INLINE NSString * app_display_name(void)
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
}

/// App Bundle Id
UIKIT_STATIC_INLINE NSString * app_bundle_Id(void)
{
    return bundleID();
}

@interface UIApplication (GLExtension)

/** 获得PhotoLibrary授权 */
- (void)privacyPhotoLibraryWithDeterminedHandle:(void (^)(BOOL authorized))handle ;
/** 获得Camera授权 */
- (void)privacyCameraWithDeterminedHandle:(void (^)(BOOL authorized))handle ;
/** 获得Microphone授权 */
- (void)privacyMicrophoneWithDeterminedHandle:(void (^)(BOOL authorized))handle ;
/** 获得AddressBook授权 */
- (void)privacyAddressBookWithDeterminedHandle:(void (^)(BOOL authorized))handle NS_AVAILABLE_IOS(9.0);
/** 获得PushNotification授权 */
- (BOOL)privacyPushNotificationWithDeterminedHandle:(void (^)(BOOL authorized))handle NS_AVAILABLE_IOS(10.0);
/** 获得Calendar授权 */
- (void)privacyCalendarWithDeterminedHandle:(void (^)(BOOL authorized))handle ;
/** 获得Location授权 */
- (BOOL)privacyLocationDeterminedHandle:(void (^)(BOOL authorized))handle;

@end
