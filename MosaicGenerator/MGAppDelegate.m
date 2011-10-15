#import "MGAppDelegate.h"

@implementation MGAppDelegate

@synthesize window = _window;
@synthesize imageView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)pickFile:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setCanCreateDirectories:NO];
    
    if ([openPanel runModal] ) {
        NSArray *files = [openPanel URLs];
        NSURL *selectedURL = [files lastObject];
        if (selectedURL) {
            NSImage *image = [[NSImage alloc] initWithContentsOfURL:selectedURL];
            if (image) {
                if ([image isValid]) {
                    self.imageView.image = image;
                }
            }
        }
    }
}

@end
