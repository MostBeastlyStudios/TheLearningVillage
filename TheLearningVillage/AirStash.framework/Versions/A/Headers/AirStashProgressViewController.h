//
//  AirStashProgressViewController.h
//  AirStash
//
//  Created by David Nelson on 6/24/2011.
//  Copyright 2011 Wearable Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AirStashProgressViewController : UIViewController {
    UILabel *nameLabel;
    UIProgressView *progress;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) IBOutlet UIProgressView *progress;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) IBOutlet UILabel *nameLabel;

- (IBAction)cancelTransfer;

@end
