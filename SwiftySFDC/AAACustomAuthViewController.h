//
//  AAACustomAuthViewController.h
//  SwiftySFDC
//
//  Created by Sugam Kalra on 14/09/15.
//  Copyright (c) 2015 Sugam Kalra. All rights reserved.
//


#import "SFAuthorizingViewController.h"

@interface AAACustomAuthViewController : SFAuthorizingViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;

@end
