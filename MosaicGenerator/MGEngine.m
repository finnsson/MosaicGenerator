//
//  MGEngine.m
//  MosaicGenerator
//
//  Created by Emil Nordling on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MGEngine.h"
#import <OpenGL/OpenGL.h>
#import <OpenGL/gl.h>
#import <QuartzCore/CoreImage.h>

@interface MGEngine(hidden)

-(double)calculateDeviationForSource:(CIImage *)sourceImage andImage:(CIImage *)image;
-(CIImage *)doTestyStuff:(CIImage *)image;
    
@end

@implementation MGEngine

-(NSImage*)generateImage:(NSURL*)sourceImageURL fromImages:(NSArray*)imageURLs {
    CIImage *bestMatch;
    double leastDeviation = INFINITY;
    CIImage* sourceImage = [CIImage imageWithContentsOfURL:sourceImageURL];
    //CGSize sourceSize = sourceImage.size;
    //CGFloat halfWidth = sourceSize.width / 2.0;
    //CGFloat halfHeight = sourceSize.height / 2.0;
    for (NSURL *imageURL in imageURLs) {
        CIImage* image = [CIImage imageWithContentsOfURL:imageURL];
        double deviation = [self calculateDeviationForSource:sourceImage andImage:image];
        if(deviation < leastDeviation) {
            bestMatch = image;
            leastDeviation = deviation;
        }
    }
    NSBitmapImageRep* rep = [[NSBitmapImageRep alloc] initWithCIImage:[self doTestyStuff:sourceImage]];
    CGImageRef cgImageRef = rep.CGImage;
    NSImage* bestImage = [[NSImage alloc] initWithCGImage:cgImageRef size:NSZeroSize];
    return bestImage;
}

-(double)calculateDeviationForSource:(CIImage *)sourceImage andImage:(CIImage *)image {
    CIContext *myCIContext;
    const NSOpenGLPixelFormatAttribute pfAttrs[] = {
        NSOpenGLPFAAccelerated,
        NSOpenGLPFANoRecovery,
        NSOpenGLPFAColorSize, 32,
        0
    };
    NSOpenGLPixelFormat *pf = [[NSOpenGLPixelFormat alloc] initWithAttributes:(void*)&pfAttrs];
    myCIContext = [CIContext contextWithCGLContext: CGLGetCurrentContext()
                                       pixelFormat: [pf CGLPixelFormatObj]
                                        colorSpace: CGColorSpaceCreateDeviceRGB()
                                           options: nil];
    
    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueAdjust setDefaults];
    [hueAdjust setValue: image forKey: @"inputImage"];
    [hueAdjust setValue: [NSNumber numberWithFloat: 3.14]
                 forKey: @"inputAngle"];
    image = [hueAdjust valueForKey: @"outputImage"];
    return 0.0;
}

-(CIImage *)doTestyStuff:(CIImage *)image {
    CIContext *myCIContext;
    const NSOpenGLPixelFormatAttribute pfAttrs[] = {
        NSOpenGLPFAAccelerated,
        NSOpenGLPFANoRecovery,
        NSOpenGLPFAColorSize, 32,
        0
    };
    NSOpenGLPixelFormat *pf = [[NSOpenGLPixelFormat alloc] initWithAttributes:(void*)&pfAttrs];
    myCIContext = [CIContext contextWithCGLContext: CGLGetCurrentContext()
                                       pixelFormat: [pf CGLPixelFormatObj]
                                        colorSpace: CGColorSpaceCreateDeviceRGB()
                                           options: nil];
    
    CIFilter *hueAdjust = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueAdjust setDefaults];
    [hueAdjust setValue: image forKey: @"inputImage"];
    [hueAdjust setValue: [NSNumber numberWithFloat: 3.14]
                 forKey: @"inputAngle"];
    return [hueAdjust valueForKey: @"outputImage"];
}

             
             
@end
