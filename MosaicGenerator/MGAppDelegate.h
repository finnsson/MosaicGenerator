#import <Cocoa/Cocoa.h>

@interface MGAppDelegate : NSObject <NSApplicationDelegate> {
    NSImageView *imageView;
    NSURL       *sourceImageURL;
    NSMutableArray     *generatorImageURLs;    
}

@property (assign) IBOutlet NSWindow *window;

@property (strong) IBOutlet NSImageView *imageView;

// Source Image: Input image
// Album: Set of images to generate Target image from.
// Target Image: 

-(IBAction) pickSourceImage:(id)sender;
-(IBAction) pickImages:(id)sender;

@end
