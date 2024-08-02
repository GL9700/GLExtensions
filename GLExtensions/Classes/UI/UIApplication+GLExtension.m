//
//  UIApplication+GLExtension.m
//  GLExtensions
//
//  Created by liguoliang on 2018/9/17.
//

#import <GLExtensions/UIApplication+GLExtension.h>
#import <GLExtensions/UIAlertController+GLExtension.h>
#import <Photos/Photos.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreTelephony/CTCellularData.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>

@implementation UIApplication (GLExtension)
//
////MARK: 获得PhotoLibrary授权
//- (void)privacyPhotoLibraryWithDeterminedHandle:(void (^)(BOOL authorized))handle {
//    __block BOOL authorized = NO;
//    PHAuthorizationStatus aStatus = [PHPhotoLibrary authorizationStatus];
//    switch(aStatus) {
//        case PHAuthorizationStatusDenied:
//        case PHAuthorizationStatusRestricted:
//            if (handle) {
//                handle(authorized);
//            }
//            break;
//        case PHAuthorizationStatusAuthorized:
//        case PHAuthorizationStatusLimited:
//            authorized = YES;
//            if (handle) {
//                handle(authorized);
//            }
//            break;
//        default:
//            [PHPhotoLibrary requestAuthorization: ^(PHAuthorizationStatus status) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    authorized = status;
//                    if (handle) {
//                        handle(authorized);
//                    }
//                });
//            }];
//            break;
//    }
//}
//
////MARK: 获得Camera授权
//- (void)privacyCameraWithDeterminedHandle:(void (^)(BOOL authorized))handle {
//    __block BOOL authorized = NO;
//    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    switch (status) {
//        case AVAuthorizationStatusDenied:
//        case AVAuthorizationStatusRestricted:
//            if (handle) {
//                handle(authorized);
//            }
//            break;
//        case AVAuthorizationStatusAuthorized:
//            authorized = YES;
//            if (handle) {
//                handle(authorized);
//            }
//            break;
//        default:
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler: ^(BOOL granted) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    authorized = granted;
//                    if (handle) {
//                        handle(authorized);
//                    }
//                });
//            }];
//            break;
//    }
//}
//
////MARK: 获得Microphone授权
//- (void)privacyMicrophoneWithDeterminedHandle:(void (^)(BOOL authorized))handle {
//    __block BOOL authorized = NO;
//    AVAudioSessionRecordPermission status = [[AVAudioSession sharedInstance] recordPermission];
//    switch (status) {
//        case AVAudioSessionRecordPermissionDenied:
//            if (handle) {
//                handle(authorized);
//            }
//            break;
//        case AVAudioSessionRecordPermissionGranted:
//            authorized = YES;
//            if (handle) {
//                handle(authorized);
//            }
//            break;
//        default:
//            [[AVAudioSession sharedInstance] requestRecordPermission: ^(BOOL granted) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    authorized = granted;
//                    if (handle) {
//                        handle(authorized);
//                    }
//                });
//            }];
//            break;
//    }
//}
//
////MARK: 获得AddressBook授权
//- (void)privacyAddressBookWithDeterminedHandle:(void (^)(BOOL authorized))handle {
//    __block BOOL authorized = NO;
//    if (@available(iOS 9.0, *)) {
//        CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
//        switch (authStatus) {
//            case CNAuthorizationStatusDenied:
//            case CNAuthorizationStatusRestricted:
//                if (handle) {
//                    handle(authorized);
//                }
//                break;
//            case CNAuthorizationStatusAuthorized:
//                authorized = YES;
//                if (handle) {
//                    handle(authorized);
//                }
//                break;
//            default:{
//                CNContactStore *contactStore = [[CNContactStore alloc] init];
//                [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler: ^(BOOL granted, NSError *_Nullable error) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        authorized = granted;
//                        if (handle) {
//                            handle(authorized);
//                        }
//                    });
//                }];
//                break;
//            }
//        }
//    }else {
//        NSLog(@"!! AddressBook授权 暂时仅支持 iOS9+ 版本");
//    }
//}
//
////MARK: 获得PushNotification授权
//- (BOOL)privacyPushNotificationWithDeterminedHandle:(void (^)(BOOL authorized))handle {
//    __block BOOL authorized = NO;
//    if (@available(iOS 10.0, *)) {
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler: ^(BOOL granted, NSError *_Nullable error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                authorized = granted;
//                if (handle) {
//                    handle(authorized);
//                }
//            });
//        }];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//        if (handle) {
//            handle(authorized);
//        }
//        return authorized;
//    }
//    else {
//        NSLog(@"!! PushNotification授权 暂时仅支持 iOS10+ 版本");
//        return NO;
//    }
//}
//
////MARK: 获得Calendar授权
//- (void)privacyCalendarWithDeterminedHandle:(void (^)(BOOL authorized))handle {
//    __block BOOL authorized = NO;
//    NSLog(@"!! 获得Calendar授权 暂时未实现");
//    if (handle) {
//        handle(authorized);
//    }
//}
//
////MARK: 获得Location授权
//- (BOOL)privacyLocationDeterminedHandle:(void (^)(BOOL authorized))handle {
//    __block BOOL authorized = NO;
//    BOOL enable = [CLLocationManager locationServicesEnabled];
//    int status = [CLLocationManager authorizationStatus];
//    if (!enable || status == 1 || status == 2) {
//        authorized = NO;
//    }
//    else {
//        authorized = YES;
//    }
//    if (handle) {
//        handle(authorized);
//    }
//    return authorized;
//}
//
@end
