//
//  UIApplication-Permissions.h
//  UIApplication-Permissions Sample
//
//  Created by Jack Rostron on 12/01/2014.
//  Copyright (c) 2014 Rostron. All rights reserved.
//  https://github.com/JackRostron/UIApplication-Permissions
//   Category on UIApplication that adds permission helpers


#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

typedef enum {
    TXPermissionTypeBluetoothLE,
    TXPermissionTypeCalendar,
    TXPermissionTypeContacts,
    TXPermissionTypeLocation,
    TXPermissionTypeMicrophone,
    TXPermissionTypeMotion,
    TXPermissionTypePhotos,
    TXPermissionTypeReminders,
} TXPermissionType;

typedef enum {
    TXPermissionAccessDenied, //User has rejected feature
    TXPermissionAccessGranted, //User has accepted feature
    TXPermissionAccessRestricted, //Blocked by parental controls or system settings
    TXPermissionAccessUnknown, //Cannot be determined
    TXPermissionAccessUnsupported, //Device doesn't support this - e.g Core Bluetooth
    TXPermissionAccessMissingFramework, //Developer didn't import the required framework to the project
} TXPermissionAccess;

@interface UIApplication (TXPermissions)

//Check permission of service. Cannot check microphone or motion without asking user for permission
-(TXPermissionAccess)tx_hasAccessToBluetoothLE;
-(TXPermissionAccess)tx_hasAccessToCalendar;
-(TXPermissionAccess)tx_hasAccessToContacts;
-(TXPermissionAccess)tx_hasAccessToLocation;
-(TXPermissionAccess)tx_hasAccessToPhotos;
-(TXPermissionAccess)tx_hasAccessToReminders;

//Request permission with callback
-(void)tx_requestAccessToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)tx_requestAccessToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)tx_requestAccessToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)tx_requestAccessToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)tx_requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

//Instance methods
-(void)tx_requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

//No failure callback available
-(void)tx_requestAccessToMotionWithSuccess:(void(^)())accessGranted;

//Needs investigating - unsure whether it can be implemented because of required delegate callbacks
//-(void)requestAccessToBluetoothLEWithSuccess:(void(^)())accessGranted;

@end
