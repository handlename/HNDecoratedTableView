#import "AppDelegate.h"
#import "SampleController.h"

@implementation AppDelegate

@synthesize window = window_;

- (void)dealloc {
    [self.window release];
    [super dealloc];
}

-(BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    [self.window makeKeyAndVisible];

    SampleController* con = [[SampleController alloc] initWithNibName:@"SampleView"
                                                               bundle:nil];
    con.view.frame = CGRectMake(con.view.frame.origin.x,
                                con.view.frame.origin.y + 20,
                                con.view.frame.size.width,
                                con.view.frame.size.height);
    [self.window addSubview:con.view];

    return YES;
}

@end
