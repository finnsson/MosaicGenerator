//
//  MGEngine.h
//  MosaicGenerator
//
//  Created by Emil Nordling on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGEngine : NSObject

-(NSImage*)generateImage:(NSURL*)sourceImageURL fromImages:(NSArray*)imageURLs;

@end
