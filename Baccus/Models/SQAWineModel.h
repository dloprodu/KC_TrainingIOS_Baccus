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
@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) NSString *wineCompanyName;
@property (strong, nonatomic) NSURL *wineCompanyWeb;
@property (strong, nonatomic) NSString *notes;
@property (strong, nonatomic) NSString *origin;
@property (nonatomic) int rating; // 1..5
@property (strong, nonatomic) NSArray *grapes;

// Métodos de clase

// Constructores de conveniencia
+(id) wineWithName: (NSString *) name
              type: (NSString *) type
             photo: (UIImage *) photo
   wineCompanyName: (NSString *) wineCompanyName
    wineCompanyWeb: (NSURL *) wineCompanyWeb
             notes: (NSString *) notes
            origin: (NSString *) origin
            rating: (int) rating
            grapes: (NSArray *) grapes;

+(id) wineWithName: (NSString *) name
              type: (NSString *) type
   wineCompanyName: (NSString *) wineCompanyName
            origin: (NSString *) origin;

// Métodos de instancia

// Inicializador Designado
-(id) initWithName: (NSString *) name
              type: (NSString *) type
             photo: (UIImage *) photo
   wineCompanyName: (NSString *) wineCompanyName
    wineCompanyWeb: (NSURL *) wineCompanyWeb
             notes: (NSString *) notes
            origin: (NSString *) origin
            rating: (int) rating
            grapes: (NSArray *) grapes;

// Inicializador de conveniencia
-(id) initWithName: (NSString *) name
              type: (NSString *) type
   wineCompanyName: (NSString *) wineCompanyName
            origin: (NSString *) origin;


@end
