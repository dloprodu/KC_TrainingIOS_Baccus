//
//  SQAWineViewController.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 04/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "SQAWineViewController.h"
#import "SQAWebViewController.h"

@interface SQAWineViewController ()

@end

@implementation SQAWineViewController

#pragma mark - Designated Initializer

-(id) initWithModel: (SQAWineModel *) model {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = model.name;
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
    
    [self syncModelWithView];
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0.13 alpha:1];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Actions

-(IBAction)displayWeb:(id)sender {
    SQAWebViewController *webVC = [[SQAWebViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Helpers

-(void) syncModelWithView {
    self.photoView.image = self.model.photo;
    self.nameLabel.text = self.model.name;
    self.companyLabel.text = self.model.wineCompanyName;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.grapesLabel.text = [self arrayToString:self.model.grapes];
    self.notesLabel.text = self.model.notes;
    [self displayRating: self.model.rating];
    
    [self.notesLabel setNumberOfLines:0];
}

-(NSString*)arrayToString: (NSArray *) array {
    NSString *repre = nil;
    
    if ([array count] == 1) {
        repre = [@"100% " stringByAppendingString:[array lastObject]];
    }
    else {
        repre = [[array componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    
    return repre;
}

-(void) clearRating {
    for (UIImageView *imageView in self.ratingView) {
        imageView.image = nil;
    }
}

-(void) displayRating:(int) rating {
    [self clearRating];
    
    UIImage *image = [UIImage imageNamed:@"splitView_score_glass"];
    
    for (int i = 0; i < rating; i++) {
        [[self.ratingView objectAtIndex:i] setImage:image];
    }
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
