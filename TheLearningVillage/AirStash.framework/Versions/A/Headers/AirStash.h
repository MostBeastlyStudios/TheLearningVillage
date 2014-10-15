//
//  AirStash.h
//  AirStash SDK
//
//  Created by David Nelson on 5/3/2011.
//  Copyright 2011-2012 Wearable Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AirStash : NSObject

typedef enum {
    AirStashStatusSuccess = 0,
    AirStashStatusBusy = 1, // Another request is active
    AirStashStatusCanceled, // The user canceled the request
    AirStashStatusProblemDetected,
    } AirStashStatus;

typedef void (^AirStashCommonErrorBlock)(AirStashStatus errorCode, NSString *reason);

//==================================================================================
// The first set of API calls provide a simple interface to find and get a file from
// an AirStash® device, or to save a file to a user chosen directory on an AirStash.
// The second set of API calls provide a set of building blocks an app can use to get
// information about AirStash devices found on the Wi-Fi network, and to save and load
// files to a specific location on a selected AirStash. These functions allow the app
// to provide its own user interface to perform the operations.
//
//==================================================================================
// Simple Interface:
// These functions use a UINavigationController and UITableViewController to present
// a list of AirStash devices found via Wi-Fi, and the directory contents as the user
// navigates the directory structure. The last functions in this group of functions
// Allows the user to select a file, but rather than downloading the file, a URL to
// access the file is returned. This method should be used when the app wants to
// handle the download. For example, to stream the file, or only read portions of the
// file.

// loadFileTo:...
// Present an interface to the user to select a file on an AirStash device,
// and transfer the file to the destination file path on this iOS device. 
// On success, the success block is called with the original filename (no path)
// on the AirStash device.
// If an error is detected, or the user cancels the operation, the error
// block is called with a corresponding non-zero status value, and a string
// describing the reason. The optional regular expression is used to limit
// the files that the user may select. It should match the files that may be selected.
// The parentViewController is used to modally present the UI to the user.

typedef void (^AirStashLoadFileSuccessBlock)(NSString *originalFileName);
typedef AirStashCommonErrorBlock AirStashLoadFileErrorBlock;

- (void)loadFileTo:(NSString*)destinationFilePath
       UsingFilter:(NSRegularExpression *)filterRegexpOrNil 
    presentingFrom:(UIViewController *)parentViewController
      successBlock:(AirStashLoadFileSuccessBlock)success
        errorBlock:(AirStashLoadFileErrorBlock)error;

// Same as previous, but does not restrict the files that may be selected.
- (void)loadFileTo:(NSString*)destinationFilePath
    presentingFrom:(UIViewController *)parentViewController
      successBlock:(AirStashLoadFileSuccessBlock)success
        errorBlock:(AirStashLoadFileErrorBlock)error;

// saveFileToAirStash:...
// Present an interface to the user to select where the given file should
// be stored on an AirStash device. The localFilePath is the path to the file 
// to be saved on the AirStash. The last path component of the path will be used
// as the filename on the destination AirStash. On success, the successBlock
// will be called. If an error is detected, or the user cancels the operation, 
// the errorBlock is called with a corresponding non-zero status value and a string
// describing the reason. The parentViewController is used to modally present
// the UI to the user.

typedef void (^AirStashSaveFileSuccessBlock)();
typedef AirStashCommonErrorBlock AirStashSaveFileErrorBlock;

- (void)saveFileToAirStash:(NSString *)localFilePath 
            presentingFrom:(UIViewController *)parentViewController
              successBlock:(AirStashSaveFileSuccessBlock)success
                errorBlock:(AirStashSaveFileErrorBlock)error;

// getFileURL...
// These methods behave the same as the loadFileTo:... methods with the exception
// that the selected file is not downloaded to the iOS device, but rather a URL
// to access the file remotely is returned instead.

typedef void (^AirStashGetFileURLSuccessBlock)(NSURL *remoteURL);
typedef AirStashCommonErrorBlock AirStashGetFileURLErrorBlock;

- (void)getFileURLUsingFilter:(NSRegularExpression *)filterRegexpOrNil 
               presentingFrom:(UIViewController *)parentViewController
                 successBlock:(AirStashGetFileURLSuccessBlock)success
                   errorBlock:(AirStashGetFileURLErrorBlock)error;

// Same as previous, but does not restrict the files that may be selected.
- (void)getFileURLPresentingFrom:(UIViewController *)parentViewController
                    successBlock:(AirStashGetFileURLSuccessBlock)success
                      errorBlock:(AirStashGetFileURLErrorBlock)error;

//==================================================================================
@end
