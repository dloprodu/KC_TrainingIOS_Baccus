//
//  SQAWebViewController.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 05/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "SQAWebViewController.h"

@interface SQAWebViewController ()

@end

@implementation SQAWebViewController

-(id) initWithModel: (SQAWineModel *) model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = @"Web";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self displayURL: self.model.wineCompanyWeb];
}

#pragma mark - Helpers

-(void) displayURL: (NSURL*) url {
    [self.activityView setHidden: NO];
    [self.activityView startAnimating];
    
    [self.browser setDelegate:self];
    [self.browser loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView stopAnimating];
    [self.activityView setHidden: YES];
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
