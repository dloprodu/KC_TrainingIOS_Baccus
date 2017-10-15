//
//  AGTWineViewController.m
//  Baccus
//
//  Created by Fernando Rodríguez Romero on 1/30/13.
//  Copyright (c) 2013 Agbo. All rights reserved.
//

#import "SQAWineViewController.h"
#import "SQAWebViewController.h"

#define kCustomFontHeader           [UIFont fontWithName:@"Valentina-Regular" size:17]
#define kCustomFontSubheader        [UIFont fontWithName:@"Valentina-Regular" size:15]
#define kCustomFontRegular          [UIFont fontWithName:@"Valentina-Regular" size:12]

@implementation SQAWineViewController

- (id)initWithModel:(SQAWineModel *)aModel {
   
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = aModel;
        self.title = aModel.name;
    }
    return self;
}

- (void)viewDidLoad {
    // como la fuente es custom, tenemos que decirselo por código
    // configuracion fuentes custom: http://codewithchris.com/common-mistakes-with-adding-custom-fonts-to-your-ios-app/
    self.nameLabel.font = kCustomFontHeader;
    self.wineryNameLabel.font = kCustomFontSubheader;
    self.typeLabel.font = kCustomFontSubheader;
    self.originLabel.font = kCustomFontSubheader;
    self.grapesLabel.font = kCustomFontSubheader;
    self.notesView.font = kCustomFontRegular;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self syncViewToModel];
    
    // si estamos en landscape, añadimos la vista que tenemos para landscape
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        [self addLandscapeViewWithProperFrame];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (UIInterfaceOrientationIsLandscape(fromInterfaceOrientation)) {
        // estamos en portrait
        [self.landscapeView removeFromSuperview];
    }
    else {
        // estamos en landscape
        [self addLandscapeViewWithProperFrame];
    }
}

- (void)addLandscapeViewWithProperFrame {
    // asignamos el frame a la vista en portrait para que se redimensione
    // si la añadimos directamente como view, al no estar dentro de un VC, no se va a redimensionar
    CGRect iPhoneScreen = [[UIScreen mainScreen] bounds];
    CGRect portraitRect = CGRectMake(0, 0, iPhoneScreen.size.height, iPhoneScreen.size.width);
    self.landscapeView.frame = portraitRect;
    [self.view addSubview:self.landscapeView];
}

#pragma mark - Actions

- (IBAction)displayWebpage:(id)sender
{    
    SQAWebViewController *webVC = [[SQAWebViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Utils

- (void)clearRatings {
    for (UIImageView *each in self.ratingViews) {
        each.image = nil;
    }
}

- (void)displayRating:(int)aRatingValue {
    [self clearRatings];
    
    UIImage *glass = [UIImage imageNamed:@"copa_cell.png"];
    
    for (int i = 0; i < aRatingValue; i++) {        
        [[self.ratingViews objectAtIndex:i] setImage:glass];
        [[self.ratingViewsPortrait objectAtIndex:i] setImage:glass];
    }
}

- (void)syncViewToModel {
    // landscape
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.wineryNameLabel.text = self.model.wineCompanyName;
    self.notesView.text = self.model.notes;
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString:self.model.grapes];
    
    // portrait
    self.nameLabelPortrait.text = self.model.name;
    self.typeLabelPortrait.text = self.model.type;
    self.originLabelPortrait.text = self.model.origin;
    self.wineryNameLabelPortrait.text = self.model.wineCompanyName;
    self.notesViewPortrait.text = self.model.notes;
    self.photoViewPortrait.image = self.model.photo;
    self.grapesLabelPortrait.text = [self arrayToString:self.model.grapes];
    
    [self displayRating:self.model.rating];
    
    NSLog(@"web: %@", self.model.wineCompanyWeb);
    if (self.model.wineCompanyWeb == nil) {
        self.webButton.enabled = NO;
    }else{
        self.webButton.enabled = YES;
    }
    
    self.title = self.model.name;
    
    // ajustamos los labels según su tamaño o reducimos la fuente en su caso ya que en el iPhone puede ocurrir que no quepa todo el texto
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.wineryNameLabel.adjustsFontSizeToFitWidth = YES;
    self.typeLabel.adjustsFontSizeToFitWidth = YES;
    self.originLabel.adjustsFontSizeToFitWidth = YES;
    [self.grapesLabel sizeToFit];
    
    // como las uvas puede tener un tamaño bastante variable (ajustado mediante sizeToFit)
    // necesitamos bastante espacio para las notas movemos subimos el el frame de la nota
    // lo hacemos solo en iPhone por las restricciones obvias de tamaño
    if (IS_PHONE) {
        CGRect newFrame = self.notesView.frame;
        CGFloat offset = newFrame.origin.y - (self.grapesLabel.frame.origin.y + self.grapesLabel.frame.size.height + 10);
        newFrame.origin.y = self.grapesLabel.frame.origin.y + self.grapesLabel.frame.size.height + 10;
        newFrame.size.height += fabsf(offset);
        self.notesView.frame = newFrame;
    }
}

- (NSString *)arrayToString:(NSArray *)anArray {
    NSString *repr;
    
    if ([anArray count] == 1) {
        repr = [@"100% " stringByAppendingString: [anArray lastObject]];
    }
    else {
        repr = [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    
    return repr;
}

#pragma mark -  AGTWineryTableViewControllerDelegate

- (void)wineryTableViewController:(SQAWineryTableViewController *)aWineryVC
                    didSelectWine:(SQAWineModel *)aWine {
    self.model = aWine;
    [self syncViewToModel];
}

@end
