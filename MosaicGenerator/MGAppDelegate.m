#import "MGAppDelegate.h"

@interface MGAppDelegate(hidden) 

+ (BOOL)URLisFile:(NSURL*)url;
+ (BOOL)URLisDirectory:(NSURL*)url;
+ (BOOL)URLisValidImage:(NSURL*)url;

@end


@implementation MGAppDelegate

@synthesize window = _window;
@synthesize imageView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)pickSourceImage:(id)sender {
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


+ (BOOL)URLisFile:(NSURL*)url
{
    NSNumber *isFile;
    if([url getResourceValue:&isFile forKey:NSURLIsRegularFileKey error:NULL]) {
        return [isFile intValue] == 1 ? YES : NO;
    }
    return NO;
}

+ (BOOL)URLisDirectory:(NSURL*)url
{
    NSNumber *isDirectory;
    if([url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL]) {
        return [isDirectory intValue] == 1 ? YES : NO;
    }
    return NO;
}

+ (BOOL)URLisValidImage:(NSURL*)url
{
    if ([MGAppDelegate URLisFile:url]) {
        NSImage *image = [[NSImage alloc] initByReferencingURL:url];
        if (image) {
            if ([image isValid]) {
                return YES;
            }
        }
    }
    return NO;
}

- (IBAction)pickImages:(id)sender {
    generatorImageURLs = [[NSMutableArray alloc] initWithCapacity:100];
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:YES];
    [openPanel setAllowsMultipleSelection:YES];
    [openPanel setCanCreateDirectories:NO];
    
    if ([openPanel runModal] ) {
        NSArray *selection = [openPanel URLs];
        for (NSURL *url in selection) {
            if ([MGAppDelegate URLisValidImage:url]) {
                [generatorImageURLs addObject:url];
            } else if([MGAppDelegate URLisDirectory:url]) {
                NSDirectoryEnumerator *dirEnum = 
                    [[NSFileManager defaultManager] enumeratorAtURL:url 
                                         includingPropertiesForKeys: 
                     [NSArray arrayWithObjects:NSURLNameKey, NSURLIsDirectoryKey, nil]
                                                            options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:nil];
                for (NSURL *subUrl in dirEnum) {
                    if ([MGAppDelegate URLisValidImage:subUrl]) {
                        [generatorImageURLs addObject:subUrl];
                    }
                }
            }
        }    
    }
    NSLog(@"Found %lu images", [generatorImageURLs count]);
}

@end
