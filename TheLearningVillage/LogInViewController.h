//
//  ViewController.h
//  TheLearningVillage
//
//  Created by Brandon Boynton on 10/7/14.
//  Copyright (c) 2014 MostBeastlyStudios. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AirStash/Airstash.h"

@interface LogInViewController : UIViewController
{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    
    IBOutlet UIActivityIndicatorView *spinner;
}

-(IBAction)login:(id)sender;

@end

