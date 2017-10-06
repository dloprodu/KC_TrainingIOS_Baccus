//
//  SQAWebViewController.h
//  Baccus
//
//  Created by David Lopez Rodriguez on 05/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQAWineModel.h"

@interface SQAWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) SQAWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

-(id) initWithModel: (SQAWineModel *) model;

@end
