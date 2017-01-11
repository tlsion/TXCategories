//
//  UIApplication-Permissions.m
//  UIApplication-Permissions Sample
//
//  Created by Jack Rostron on 12/01/2014.
//  Copyright (c) 2014 Rostron. All rights reserved.
//

#import "UIApplication+TXPermissions.h"
#import <objc/runtime.h>

//Import required frameworks
#import <AddressBook/AddressBook.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <EventKit/EventKit.h>

typedef void (^TXLocationSuccessCallback)();
typedef void (^TXLocationFailureCallback)();

static char TXPermissionsLocationManagerPropertyKey;
static char TXPermissionsLocationBlockSuccessPropertyKey;
static char TXPermissionsLocationBlockFailurePropertyKey;

@interface UIApplication () <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *tx_permissionsLocationManager;
@property (nonatomic, copy) TXLocationSuccessCallback tx_locationSuccessCallbackProperty;
@property (nonatomic, copy) TXLocationFailureCallback tx_locationFailureCallbackProperty;
@end


@implementation UIApplication (Permissions)


#pragma mark - Check permissions
-(TXPermissionAccess)hasAccessToBluetoothLE {
    switch ([[[CBCentralManager alloc] init] state]) {
        case CBCentralManagerStateUnsupported:
            return TXPermissionAccessUnsupported;
            break;
            
        case CBCentralManagerStateUnauthorized:
            return TXPermissionAccessDenied;
            break;
            
        default:
            return TXPermissionAccessGranted;
            break;
    }
}

-(TXPermissionAccess)hasAccessToCalendar {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:
            return TXPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return TXPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return TXPermissionAccessRestricted;
            break;
            
        default:
            return TXPermissionAccessUnknown;
            break;
    }
}

-(TXPermissionAccess)hasAccessToContacts {
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            return TXPermissionAccessGranted;
            break;
            
        case kABAuthorizationStatusDenied:
            return TXPermissionAccessDenied;
            break;
            
        case kABAuthorizationStatusRestricted:
            return TXPermissionAccessRestricted;
            break;
            
        default:
            return TXPermissionAccessUnknown;
            break;
    }
}

-(TXPermissionAccess)hasAccessToLocation {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorized:
            return TXPermissionAccessGranted;
            break;
            
        case kCLAuthorizationStatusDenied:
            return TXPermissionAccessDenied;
            break;
            
        case kCLAuthorizationStatusRestricted:
            return TXPermissionAccessRestricted;
            break;
            
        default:
            return TXPermissionAccessUnknown;
            break;
    }
    return TXPermissionAccessUnknown;
}

-(TXPermissionAccess)hasAccessToPhotos {
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusAuthorized:
            return TXPermissionAccessGranted;
            break;
            
        case ALAuthorizationStatusDenied:
            return TXPermissionAccessDenied;
            break;
            
        case ALAuthorizationStatusRestricted:
            return TXPermissionAccessRestricted;
            break;
            
        default:
            return TXPermissionAccessUnknown;
            break;
    }
}

-(TXPermissionAccess)hasAccessToReminders {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) {
        case EKAuthorizationStatusAuthorized:
            return TXPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return TXPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return TXPermissionAccessRestricted;
            break;
            
        default:
            return TXPermissionAccessUnknown;
            break;
    }
    return TXPermissionAccessUnknown;
}


#pragma mark - Request permissions
-(void)tx_requestAccessToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)tx_requestAccessToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if(addressBook) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    accessGranted();
                } else {
                    accessDenied();
                }
            });
        });
    }
}

-(void)tx_requestAccessToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)tx_requestAccessToMotionWithSuccess:(void(^)())accessGranted {
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    [motionManager startActivityUpdatesToQueue:motionQueue withHandler:^(CMMotionActivity *activity) {
        accessGranted();
        [motionManager stopActivityUpdates];
    }];
}

-(void)tx_requestAccessToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        accessGranted();
    } failureBlock:^(NSError *error) {
        accessDenied();
    }];
}

-(void)tx_requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}


#pragma mark - Needs investigating
/*
 -(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted {
 //REQUIRES DELEGATE - NEEDS RETHINKING
 }
 */

-(void)tx_requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    self.tx_permissionsLocationManager = [[CLLocationManager alloc] init];
    self.tx_permissionsLocationManager.delegate = self;
    
    self.tx_locationSuccessCallbackProperty = accessGranted;
    self.tx_locationFailureCallbackProperty = accessDenied;
    [self.tx_permissionsLocationManager startUpdatingLocation];
}


#pragma mark - Location manager injection
-(CLLocationManager *)tx_permissionsLocationManager {
    return objc_getAssociatedObject(self, &TXPermissionsLocationManagerPropertyKey);
}

-(void)setTx_permissionsLocationManager:(CLLocationManager *)manager {
    objc_setAssociatedObject(self, &TXPermissionsLocationManagerPropertyKey, manager, OBJC_ASSOCIATION_RETAIN);
}

-(TXLocationSuccessCallback)locationSuccessCallbackProperty {
    return objc_getAssociatedObject(self, &TXPermissionsLocationBlockSuccessPropertyKey);
}

-(void)setTx_locationSuccessCallbackProperty:(TXLocationSuccessCallback)locationCallbackProperty {
    objc_setAssociatedObject(self, &TXPermissionsLocationBlockSuccessPropertyKey, locationCallbackProperty, OBJC_ASSOCIATION_COPY);
}

-(TXLocationFailureCallback)locationFailureCallbackProperty {
    return objc_getAssociatedObject(self, &TXPermissionsLocationBlockFailurePropertyKey);
}

-(void)setTx_locationFailureCallbackProperty:(TXLocationFailureCallback)locationFailureCallbackProperty {
    objc_setAssociatedObject(self, &TXPermissionsLocationBlockFailurePropertyKey, locationFailureCallbackProperty, OBJC_ASSOCIATION_COPY);
}


#pragma mark - Location manager delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorized) {
        self.locationSuccessCallbackProperty();
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        self.locationFailureCallbackProperty();
    }
}

@end
