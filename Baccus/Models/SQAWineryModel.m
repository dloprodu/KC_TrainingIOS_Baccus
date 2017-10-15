//
//  SQAWineryModel.m
//  Baccus
//
//  Created by David Lopez Rodriguez on 07/10/2017.
//  Copyright © 2017 David López Rodriguez. All rights reserved.
//

#import "SQAWineModel.h"
#import "SQAWineryModel.h"

@interface SQAWineryModel ()

@property (strong, nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;

@end

@implementation SQAWineryModel

//@synthesize isLoaded = _isLoaded;

#pragma mark - Properties

-(NSUInteger) redWineCount {
    return [self.redWines count];
}

-(NSUInteger) whiteWineCount {
    return [self.whiteWines count];
}

-(NSUInteger) otherWineCount {
    return [self.otherWines count];
}

#pragma mark - Designated Initializer

-(id)init {
    if (self = [super init]) {
        _isLoaded = NO;
        /**
        SQAWineModel *tintorro = [SQAWineModel wineWithName:@"Bembibre"
                                                       type:@"tinto"
                                                      photoURL:nil
                                            wineCompanyName:@"Dominio de Tares"
                                             wineCompanyWeb:[NSURL URLWithString:@"https://www.dominiodetares.com"]
                                                      notes:@"Este vino muestra toda la complejidad y la elegancia de la variedad Mencía. En fase visual luce un color rojo picota muy cubierto con tonalidades violáceas en el menisco. En nariz aparecen recuerdos frutales muy intensos de frutas rojas (frambuesa, cereza) y una potente ciruela negra, así como tonos florales de la gama de las rosas y violetas, vegetales muy elegantes y complementarios, hojarasca verde, tabaco y maderas aromáticas (sándalo) que le brindan un toque ciertamente perfumado."
                                                     origin:@"El Bierzo"
                                                     rating:5
                                                     grapes:@[@"Mencía"]];
        
        [tintorro setPhoto:[UIImage imageNamed:@"bembibre.jpg"]];
        
        SQAWineModel *albarinno = [SQAWineModel wineWithName:@"Zárate"
                                                        type:@"white"
                                                       photoURL:nil
                                             wineCompanyName:@"Zárate"
                                              wineCompanyWeb:[NSURL URLWithString:@"http://bodegas-zarate.com"]
                                                       notes:@"El albariño Zarate es un vino blanco monovarietal que pertenece a la Denominación de Origen Rías Baixas. Considerado por la crítica especializada como uno de los grandes vinos blancos del mundo, el albariño ya es todo un mito."
                                                      origin:@"Rias Bajas"
                                                      rating:4
                                                      grapes:@[@"Albariño"]];
        
        [albarinno setPhoto:[UIImage imageNamed:@"zarate.gif"]];
        
        SQAWineModel *champagne = [SQAWineModel wineWithName:@"Comtes de Champagne"
                                                        type:@"other"
                                                       photoURL:nil
                                             wineCompanyName:@"Champagne Taittinger"
                                              wineCompanyWeb:[NSURL URLWithString:@"http://www.taittinger.fr"]
                                                       notes:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc purus. Curabitur eu velit mauris. Curabitur magna nisi, ullamcorper ac bibendum ac, laoreet et justo. Praesent vitae tortor quis diam luctus condimentum. Suspendisse potenti. In magna elit, interdum sit amet facilisis dictum, bibendum nec libero. Maecenas pellentesque posuere vehicula. Vivamus eget nisl urna, quis egestas sem. Vivamus at venenatis quam. Sed eu nulla a orci fringilla pulvinar ut eu diam. Morbi nibh nibh, bibendum at laoreet egestas, scelerisque et nisi. Donec ligula quam, semper nec bibendum in, semper eget dolor. In hac habitasse platea dictumst. Maecenas adipiscing semper rutrum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;"
                                                      origin:@"Champagne"
                                                      rating:5
                                                      grapes:@[@"Chardonnay"]];
        
        [champagne setPhoto:[UIImage imageNamed:@"comtesDeChampagne.jpg"]];
        
        _redWines = [@[tintorro] mutableCopy];
        _whiteWines = [@[albarinno] mutableCopy];
        _otherWines = [@[champagne] mutableCopy];
       */
    }
    return self;
}

#pragma mark - Methods

-(SQAWineModel*) redWineAtIndex: (NSInteger) index {
    return [self.redWines objectAtIndex:index];
}

-(SQAWineModel*) whiteWineAtIndex: (NSInteger) index {
    return [self.whiteWines objectAtIndex:index];
}

-(SQAWineModel*) otherWineAtIndex: (NSInteger) index {
    return [self.otherWines objectAtIndex:index];
}

-(void)load {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://static.keepcoding.io/baccus/wines.json"]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
         completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
             
             //NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
             //NSInteger statusCode = httpResponse.statusCode;
             //if (statusCode >= 200 && statusCode < 300)
             
             if (data != nil) {
                 // No ha habido error
                 NSArray * JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:kNilOptions
                                                                           error:&error];
                 
                 if (JSONObjects != nil) {
                     // No ha habido error
                     for (NSDictionary *dict in JSONObjects){
                         SQAWineModel *wine = [[SQAWineModel alloc] initWithDictionary:dict];
                         
                         if (wine.name == nil) {
                             continue;
                         }
                         
                         // Añadimos al tipo adecuado
                         if ([wine.type isEqualToString:RED_WINE_KEY]) {
                             if (!self.redWines) {
                                 self.redWines = [NSMutableArray arrayWithObject:wine];
                             }
                             else {
                                 [self.redWines addObject:wine];
                             }
                         }
                         else if ([wine.type isEqualToString:WHITE_WINE_KEY]) {
                             if (!self.whiteWines) {
                                 self.whiteWines = [NSMutableArray arrayWithObject:wine];
                             }
                             else {
                                 [self.whiteWines addObject:wine];
                             }
                         }
                         else {
                             if (!self.otherWines) {
                                 self.otherWines = [NSMutableArray arrayWithObject:wine]; //fix/11a
                             }
                             else {
                                 [self.otherWines addObject:wine]; //fix/11a
                             }
                         }
                     }
                     
                     _isLoaded = true;
                     [self.delegate wineryDidLoad:self];
                 }
                 else {
                     _isLoaded = true;
                     [self.delegate wineryDidLoad:self];
                     
                     // Se ha producido un error al parsear el JSON
                     NSLog(@"Error al parsear JSON: %@", error.localizedDescription);
                 }
             }
             else{
                 _isLoaded = true;
                 [self.delegate wineryDidLoad:self];
                 
                 // Error al descargar los datos del servidor
                 NSLog(@"Error al descargar datos del servidor: %@", error.localizedDescription);
             }
             
         }] resume];    
}

@end
