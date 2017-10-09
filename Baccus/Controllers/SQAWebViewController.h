//
//  SQAWebViewController.h
//  Baccus
//
//  Created by David Lopez Rodriguez on 05/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQAWineModel;

@interface SQAWebViewController : UIViewController <UIWebViewDelegate>

#pragma mark - Properties

@property (strong, nonatomic) SQAWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

#pragma mark - Designated Initializer

-(id) initWithModel: (SQAWineModel *) model;

@end
