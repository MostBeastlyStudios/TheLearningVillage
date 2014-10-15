//
//  ViewController.m
//  TheLearningVillage
//
//  Created by Brandon Boynton on 10/7/14.
//  Copyright (c) 2014 MostBeastlyStudios. All rights reserved.
//

#import "LogInViewController.h"
#import "AirStash/Airstash.h"


@interface LogInViewController () {
    
}

@property (strong,nonatomic) AirStash *airstash;
@property (strong,nonatomic) NSString *path;
@property (strong,nonatomic) NSArray *files;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    username.delegate = self;
    password.delegate = self;
    spinner.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Log In Button
//////////////////////////
///----Login Button----///
//////////////////////////

-(IBAction)login:(id)sender {
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    spinner.hidden = NO;
    NSString *usernameString = username.text;
    NSString *truePassword = [self passwordForUsername:usernameString];
    NSLog(@"%@", truePassword);
    NSLog(@"%@", password.text);
    if (truePassword == password.text) {
        //success block
        [self presentAlert:@"Yay!" :@"You did it Brandon!"];
    }
    else if (truePassword != password.text) {
        //failure block
        [self presentAlert:@"Incorrect" :@"You have entered an incorrect username or password. Please try again"];
    }
}

-(NSString *)passwordForUsername:(NSString *)username {
    
    /*
    NSLog(@"Get a file from AirStash");
    // We allocate an AirStash object to handle the request.
    _airstash = [[AirStash alloc] init];
    // Figure out a temporary file to hold the downloaded file.
    NSString *temporaryDirectory = NSTemporaryDirectory();
    NSString *tempFile = [temporaryDirectory stringByAppendingPathComponent:@"AirStashTemp"];
    [_airstash loadFileTo:tempFile
              UsingFilter:nil
           presentingFrom:self
             successBlock:^(NSString *origname) {
                 NSString *msg = [NSString stringWithFormat:@"Success loading file from AirStash: original filename: %@", origname];
                 NSLog(@"%@", msg);
                 [self presentAlertWithMessage:msg];
                 // Now move the file from the temp location to the Documents directory, using the
                 // original name the file had on the AirStash device.
                 NSURL *docDir = [self getDocumentsDirectory];
                 assert(docDir != nil);
                 NSLog(@"%@", docDir);
                 NSURL *newURL = [docDir URLByAppendingPathComponent:origname];
                 [self moveFile:[NSURL fileURLWithPath:tempFile] to:newURL];
                 // Release the AirStash object to free up any memory it holds.
                 self.airstash = nil;
             }
               errorBlock:^(AirStashStatus errorCode, NSString *reason) {
                   NSString *msg = [NSString stringWithFormat:@"Problem loading file from AirStash: (%d) %@", errorCode, reason];
                   NSLog(@"%@", msg);
                   [self presentAlertWithMessage:msg];
                   // Release the AirStash object to free up any memory it holds.
                   self.airstash = nil;
               }];
     */
    
    NSString *fullUsernameFile = [NSString stringWithFormat:@"%@.txt", username];
    NSString *fullStringURL = [NSString stringWithFormat:@"http://airstash.local/files/%@", fullUsernameFile];
    NSURL *fullURL = [NSURL URLWithString:fullStringURL];
    NSError* error = nil;
    NSStringEncoding enc;
    NSString *userData = [NSString stringWithContentsOfURL:fullURL usedEncoding:&enc error:&error];
    NSArray *separatedData = [userData componentsSeparatedByString: @"+"];
    NSLog(@"%@", separatedData);
    NSString *truePassword = [separatedData objectAtIndex:1];
    NSLog(@"%@", truePassword);
    return truePassword;
}

- (NSURL*)getDocumentsDirectory
{
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSArray *paths = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    //NSLog(@"document directory: %@", paths);
    return [paths objectAtIndex:0];
}

- (void)moveFile:(NSURL*)srcFile to:(NSURL*)destFile
{
    NSError *error = nil;
    NSFileManager *fm = [[NSFileManager alloc] init];
    [fm moveItemAtURL:srcFile toURL:destFile error:&error];
    if (error) {
        // A real application would detect the overwrite case and do something reasonable.
        // This is a demo, so I'm being really lazy and just reporting the "error".
        NSLog(@"Error detected during move from %@ to %@   error: %@", srcFile, destFile, [error localizedDescription]);
        [fm removeItemAtURL:srcFile error:nil];
    }
}


/*
- (void)getFileAction
{
    NSLog(@"Get a file from AirStash");
    // We allocate an AirStash object to handle the request.
    self.airstash = [[AirStash alloc] init];
    // Figure out a temporary file to hold the downloaded file.
    NSString *temporaryDirectory = NSTemporaryDirectory();
    NSString *tempFile = [temporaryDirectory stringByAppendingPathComponent:@"AirStashTemp"];
    [_airstash loadFileTo:tempFile
              UsingFilter:nil
           presentingFrom:self
             successBlock:^(NSString *origname) {
                 NSString *msg = [NSString stringWithFormat:@"Success loading file from AirStash: original filename: %@", origname];
                 NSLog(@"%@", msg);
                 [self presentAlertWithMessage:msg];
                 // Now move the file from the temp location to the Documents directory, using the
                 // original name the file had on the AirStash device.
                 NSURL *docDir = [self getDocumentsDirectory];
                 assert(docDir != nil);
                 NSURL *newURL = [docDir URLByAppendingPathComponent:origname];
                 [self moveFile:[NSURL fileURLWithPath:tempFile] to:newURL];
                 // Release the AirStash object to free up any memory it holds.
                 self.airstash = nil;
             }
               errorBlock:^(AirStashStatus errorCode, NSString *reason) {
                   NSString *msg = [NSString stringWithFormat:@"Problem loading file from AirStash: (%d) %@", errorCode, reason];
                   NSLog(@"%@", msg);
                   [self presentAlertWithMessage:msg];
                   // Release the AirStash object to free up any memory it holds.
                   self.airstash = nil;
               }];
}

- (NSURL*)getDocumentsDirectory
{
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSArray *paths = [fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSLog(@"document directory: %@", paths);
    return [paths objectAtIndex:0];
}

- (void)moveFile:(NSURL*)srcFile to:(NSURL*)destFile
{
    NSError *error = nil;
    NSFileManager *fm = [[NSFileManager alloc] init];
    [fm moveItemAtURL:srcFile toURL:destFile error:&error];
    if (error) {
        // A real application would detect the overwrite case and do something reasonable.
        // This is a demo, so I'm being really lazy and just reporting the "error".
        NSLog(@"Error detected during move from %@ to %@   error: %@", srcFile, destFile, [error localizedDescription]);
        [fm removeItemAtURL:srcFile error:nil];
    }
}
 */

#pragma mark - UIAlertView
/////////////////////////
///----UIAlertView----///
/////////////////////////

- (void)presentAlert:(NSString*)title :(NSString*)message
{
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:message
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Keyboard Offset
/////////////////////////////
///----Keyboard Offset----///
/////////////////////////////

#define kOFFSET_FOR_KEYBOARD 300.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0) {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0) {
        [self setViewMovedUp:NO];
    }
}

-(void)setViewMovedUp:(BOOL)movedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;

    if (movedUp) {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }

    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (void)viewWillAppear:(BOOL)animated {
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - Manage Return Button
///////////////////////////
///----Return Button----///
///////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == password) {
        [theTextField resignFirstResponder];
        [self login:nil];
    }
    else if (theTextField == username) {
        [theTextField resignFirstResponder];
        [password becomeFirstResponder];
    }
    else {
        [theTextField resignFirstResponder];
    }
    return YES;
}



@end
