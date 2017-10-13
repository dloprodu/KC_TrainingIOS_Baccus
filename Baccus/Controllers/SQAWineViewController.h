//
//  SQAWineViewController.h
//  Baccus
//
//  Created by David Lopez Rodriguez on 04/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQAWineryTableViewController.h"

#define IS_PHONE UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone

@class SQAWineModel;

@interface SQAWineViewController : UIViewController<UISplitViewControllerDelegate, WineryTableViewControllerDelegate>

#pragma mark - Properties

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingView;

@property (strong, nonatomic) SQAWineModel *model;

#pragma mark - Designated Initializer

-(id) initWithModel: (SQAWineModel *) model;

#pragma mark - Actions

-(IBAction)displayWeb:(id)sender;

@end
