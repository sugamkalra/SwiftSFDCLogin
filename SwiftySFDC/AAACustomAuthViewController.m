//
//  AAACustomAuthViewController.m
//  SwiftySFDC
//
//  Created by Sugam Kalra on 14/09/15.
//  Copyright (c) 2015 Sugam Kalra. All rights reserved.
//

#import "AAACustomAuthViewController.h"

#import "SFAuthenticationManager.h"

@interface SFAuthenticationManager(AAA)
- (void)dismissAuthViewControllerIfPresent;
@end

@interface AAACustomAuthViewController ()
@property (nonatomic) BOOL isInitialWebViewDidFinishLoad;
@property (nonatomic) id<UIWebViewDelegate> parentDelegate;
@end

@implementation AAACustomAuthViewController

@synthesize userName;
@synthesize isInitialWebViewDidFinishLoad;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];

    
    isInitialWebViewDidFinishLoad = YES;
    UIWebView *webView = (UIWebView *)self.oauthView;

    webView.isAccessibilityElement = YES;
    webView.accessibilityLabel = @"OAuth web view";

    self.parentDelegate = webView.delegate;
    webView.delegate = self;

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(keyWindow.frame.size.width-35, 30, 50, 50)];
    [button setImage:[UIImage imageNamed:@"CustomerModalBtnClose"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
    [webView addSubview:button];
}

- (void)backToLogin
{
    UIWebView *webView = (UIWebView *)self.oauthView;
    [webView stopLoading];
    webView.delegate = nil;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SFWebViewCancelNotification" object:nil];
    
    [[SFAuthenticationManager sharedManager] dismissAuthViewControllerIfPresent];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
   
    if (isInitialWebViewDidFinishLoad) {
        NSString *command = [[NSString alloc] initWithFormat:@"document.getElementById('username').value='%@';document.getElementById('password').value='%@';", self.userName ? self.userName : @"", self.password ? self.password : @""];
        [webView stringByEvaluatingJavaScriptFromString:command];
    
        isInitialWebViewDidFinishLoad = NO;
    }
    
    [self.parentDelegate webViewDidFinishLoad:webView];
    
}

# pragma UIWebViewDelegate method

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.parentDelegate webView:webView didFailLoadWithError:error];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [self.parentDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.parentDelegate webViewDidStartLoad:webView];
}

@end
