//
//  SQAWineryViewControllerTableViewController.h
//  Baccus
//
//  Created by David Lopez Rodriguez on 07/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQAWineModel.h"
#import "SQAWineryModel.h"

#define RED_WINE_SECTION   0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

#define NEW_WINE_NOTIFICATION_NAME @"newWine"
#define WINE_KEY @"wine"

#define SECTION_KEY @"section"
#define ROW_KEY @"row"
#define LAST_WINE_KEY @"lastWine"

#define IS_PHONE UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone

// Declaraciones adelantadas
@class SQAWineryTableViewController;

// Delgado
@protocol SQAWineryTableViewControllerDelegate <NSObject>

-(void)wineryTableViewController: (SQAWineryTableViewController *) wineryVC didSelectWine: (SQAWineModel *) wine;

@end

// ViewController
@interface SQAWineryTableViewController : UITableViewController<UISplitViewControllerDelegate, WineryDelegate>

#pragma mark - Properties

@property (strong, nonatomic) SQAWineryModel *model;
@property (weak, nonatomic) id<SQAWineryTableViewControllerDelegate> delegate;

#pragma mark - Designated Initializer

-(id) initWithModel: (SQAWineryModel*) model
              style: (UITableViewStyle) style;

-(SQAWineModel*) lastSelectedWine;

@end
