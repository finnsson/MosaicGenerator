#import <Cocoa/Cocoa.h>

@interface MGAppDelegate : NSObject <NSApplicationDelegate> {
    NSImageView *imageView;
}

@property (assign) IBOutlet NSWindow *window;

@property (strong) IBOutlet NSImageView *imageView;

-(IBAction) pickFile:(id)sender;

@end
