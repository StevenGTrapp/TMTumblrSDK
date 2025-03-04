//
//  ViewController.h
//  ExampleiOS
//
//  Created by Kenny Ackerson on 1/6/16.
//  Copyright © 2016 tumblr. All rights reserved.
//  Created by Steven G. Trapp on 10/10/24.

#import <UIKit/UIKit.h>
#import <TMTumblrSDK/TMAPIClient.h>
#import <TMTumblrSDK/TMOAuthAuthenticator.h>

@interface ViewController : UIViewController

- (instancetype)initWithSession:(TMURLSession *)session authenticator:(TMOAuthAuthenticator *)authenticator;

@end
