//
//  UIApplication+Extension.m
//  WCExtensions
//
//  Created by liguoliang on 2018/9/17.
//

#import "UIApplication+Extension.h"
#import <Photos/Photos.h>
#import <UserNotifications/UserNotifications.h>
#import <UIAlertController+Extension.h>
#import <CoreLocation/CoreLocation.h>

@implementation UIApplication (Extension)
/** 获得PhotoLibrary授权 */
+ (BOOL)privacyAuthorizedForPhotoLibrary:(BOOL)needAlert {
    __block BOOL allow = NO;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusAuthorized){
        allow = YES;
    }else if(status == PHAuthorizationStatusNotDetermined){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized) {
                allow = YES;
            }
        }];
    }else{
        if (needAlert) {
            NSString *str = [NSString stringWithFormat:@"请在“设置->隐私->照片”选项中,允许%@访问你的相册。", [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey]];
            [[UIAlertController alertWithTitle:@"提示" message:str singleButton:@"好的" event:nil] show];
        }
    }
    return allow;
}

/** 获得Camera授权 */
+ (BOOL)privacyAuthorizedForCamera:(BOOL)needAlert {
    __block BOOL allow = NO;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized) {
        allow = YES;
    }else if(status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                allow = YES;
            }
        }];
    }else{
        if (needAlert) {
            NSString *str = [NSString stringWithFormat:@"请在“设置->隐私->相机”选项中,允许%@访问你的相机。", [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey]];
            [[UIAlertController alertWithTitle:@"提示" message:str singleButton:@"好的" event:nil] show];
        }
    }
    return allow;
}

/** 已获得Microphone授权 */
+ (BOOL)privacyAuthorizedForMicrophone:(BOOL)needAlert {
    __block BOOL allow = NO;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if(status == AVAuthorizationStatusAuthorized) {
        allow = YES;
    }else if(status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if(granted){
                allow = YES;
            }
        }];
    }else{
        if (needAlert) {
            NSString *str = [NSString stringWithFormat:@"请在“设置->隐私->麦克风”选项中,允许%@访问你的麦克风。", [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey]];
            [[UIAlertController alertWithTitle:@"提示" message:str singleButton:@"好的" event:nil] show];
        }
    }
    return allow;
}

/** 已获得AddressBook授权 */
+ (BOOL)privacyAuthorizedForAddressBook:(BOOL)needAlert {
    return YES;
}

/** 已获得RemoteNotificationPush授权 */
+ (BOOL)privacyAuthorizedForRemoteNotification:(BOOL)needAlert {
    __block BOOL allow = NO;
    if(@available(iOS 10.0 , *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if(settings.authorizationStatus == UNAuthorizationStatusAuthorized){
                allow = YES;
            }else if(settings.authorizationStatus == UNAuthorizationStatusNotDetermined){
                [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    allow = granted;
                }];
            }else{
                if (needAlert) {
                    NSString *str = [NSString stringWithFormat:@"请在“设置->通知”中,允许%@的通知。", [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey]];
                    [[UIAlertController alertWithTitle:@"提示" message:str singleButton:@"好的" event:nil] show];
                }
            }
       }];
    }else{
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (setting.types != UIUserNotificationTypeNone) {
            allow = YES;
        }
    }
    
    return allow;
}

/** 已获得Calendar授权 */
+ (BOOL)privacyAuthorizedForCalendar:(BOOL)needAlert {
    return YES;
}

/** 已获得Location授权 */
+ (BOOL)privacyAuthorizedForLocationInUse:(BOOL)needAlert {
    CLLocationManager *location = [[CLLocationManager alloc]init];
    [location requestWhenInUseAuthorization];
    BOOL allow = NO;
    static BOOL first;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if([CLLocationManager locationServicesEnabled]==NO || status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        if (needAlert || first) {
            NSString *str = [NSString stringWithFormat:@"请在“设置->隐私->定位服务”选项中,允许%@访问你位置。", [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey]];
            [[UIAlertController alertWithTitle:@"提示" message:str singleButton:@"好的" event:nil] show];
        }else{
            first = YES;
        }
    }else if(status == kCLAuthorizationStatusNotDetermined){
        allow = YES;
    }
    return allow;
}
/** 已获得Location授权 */
+ (BOOL)privacyAuthorizedForLocationAlways:(BOOL)needAlert {
    CLLocationManager *location = [[CLLocationManager alloc]init];
    [location requestAlwaysAuthorization];
    BOOL allow = NO;
    static BOOL first;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if([CLLocationManager locationServicesEnabled]==NO || status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        if (needAlert || first) {
            NSString *str = [NSString stringWithFormat:@"请在“设置->隐私->定位服务”选项中,允许%@访问你位置。", [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey]];
            [[UIAlertController alertWithTitle:@"提示" message:str singleButton:@"好的" event:nil] show];
        }else{
            first = YES;
        }
    }else if(status == kCLAuthorizationStatusNotDetermined){
        allow = YES;
    }
    return allow;
}

@end
