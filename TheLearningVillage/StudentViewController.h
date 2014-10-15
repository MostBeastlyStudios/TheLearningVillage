//
//  StudentViewController.h
//  TheLearningVillage
//
//  Created by Brandon Boynton on 10/14/14.
//  Copyright (c) 2014 MostBeastlyStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentViewController : UIViewController {
    IBOutlet UIWebView *webView;
}

-(IBAction)math:(id)sender;
-(IBAction)english:(id)sender;
-(IBAction)biology:(id)sender;

@end
