//
//  UIApplication+GLExtension.h
//  GLExtensions
//
//  Created by liguoliang on 2018/9/17.
//

#import <UIKit/UIKit.h>

/** app版本 */
UIKIT_STATIC_INLINE NSArray * releaseVersion()
{
    NSString *str = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [str componentsSeparatedByString:@"."];
}

/** build版本 */
UIKIT_STATIC_INLINE NSArray * buildVersion()
{
    NSString *str = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
    return [str componentsSeparatedByString:@"."];
}

/** application bundle id */
UIKIT_STATIC_INLINE NSString * bundleID()
{
    return [[NSBundle mainBundle].infoDictionary objectForKey:(NSString *)kCFBundleIdentifierKey];
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
