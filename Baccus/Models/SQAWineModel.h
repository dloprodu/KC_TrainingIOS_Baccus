//
//  SQAWineModel.h
//  Baccus
//
//  Created by David Lopez Rodriguez on 03/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQAWineModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSString *wineCompanyName;
@property (strong, nonatomic) NSURL *wineCompanyWeb;
@property (strong, nonatomic) NSString *notes;
@property (strong, nonatomic) NSString *origin;
@property (nonatomic) int rating; // 1..5
@property (strong, nonatomic) NSArray<NSString *> *grapes;

//@property (strong, nonatomic, readonly) UIImage *photo;
@property (strong, nonatomic) UIImage *photo;

#pragma mark - Convenience Constructors

+(id) wineWithName: (NSString *) name
              type: (NSString *) type
          photoURL: (NSURL *) photoURL
   wineCompanyName: (NSString *) wineCompanyName
    wineCompanyWeb: (NSURL *) wineCompanyWeb
             notes: (NSString *) notes
            origin: (NSString *) origin
            rating: (int) rating
            grapes: (NSArray<NSString *> *) grapes;

+(id) wineWithName: (NSString *) name
              type: (NSString *) type
   wineCompanyName: (NSString *) wineCompanyName
            origin: (NSString *) origin;

#pragma mark - Designated Initializer

-(id) initWithName: (NSString *) name
              type: (NSString *) type
          photoURL: (NSURL *) photoURL
   wineCompanyName: (NSString *) wineCompanyName
    wineCompanyWeb: (NSURL *) wineCompanyWeb
             notes: (NSString *) notes
            origin: (NSString *) origin
            rating: (int) rating
            grapes: (NSArray<NSString *> *) grapes;

#pragma mark - Convenience Initializers

-(id) initWithName: (NSString *) name
              type: (NSString *) type
   wineCompanyName: (NSString *) wineCompanyName
            origin: (NSString *) origin;

-(id) initWithDictionary:(NSDictionary *) dic;

-(NSDictionary*) proxyForJSON;

-(void) photoWithBlock:(void (^)(UIImage *image))completionBlock;
@end
