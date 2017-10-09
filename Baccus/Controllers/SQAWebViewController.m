//
//  SQAWebViewController.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 05/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "SQAWebViewController.h"
#import "SQAWineryTableViewController.h"
#import "SQAWineModel.h"

@interface SQAWebViewController ()

@end

@implementation SQAWebViewController

#pragma mark - Designated Initializer

-(id) initWithModel: (SQAWineModel *) model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = @"Web";
    }
    
    return self;
}

#pragma mark - View Lifecycle

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
    
    // Notification subscription
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:NEW_WINE_NOTIFICATION_NAME
                 object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Notification unsubscription
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Helpers

-(void) wineDidChange: (NSNotification *) notification {
    self.model = [[notification userInfo] objectForKey:WINE_KEY];
    
    [self displayURL: [self.model wineCompanyWeb]];
}

-(void) displayURL: (NSURL*) url {
    [self.activityView setHidden: NO];
    [self.activityView startAnimating];
    
    [self.browser setDelegate:self];
    [self.browser loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - UIWebView Delegate

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
