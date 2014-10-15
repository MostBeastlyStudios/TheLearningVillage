//
//  StudentViewController.m
//  TheLearningVillage
//
//  Created by Brandon Boynton on 10/14/14.
//  Copyright (c) 2014 MostBeastlyStudios. All rights reserved.
//

#import "StudentViewController.h"
#import <AirStash/AirStash.h>

@interface StudentViewController ()

@end

@implementation StudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    webView.backgroundColor = [UIColor blackColor];
}

-(IBAction)math:(id)sender {
    [self playVideo:@"video.mp4"];
}

-(void)playVideo:(NSString *)file {
    NSString *fullURL = [NSString stringWithFormat:@"http://airstash.local/files/%@",file];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
