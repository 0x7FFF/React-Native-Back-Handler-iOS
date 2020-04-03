#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>


@interface BackHandlerIOS : NSObject <RCTBridgeModule>
@end

@implementation BackHandlerIOS

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

- (UIViewController *)currentTopViewController
{
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)topVC topViewController];
    }
    return topVC;
}

RCT_REMAP_METHOD(exitApp, exitApp:(NSDictionary *)rootTag) {
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            [[self currentTopViewController] dismissViewControllerAnimated:YES completion:nil];
        }
        @catch(NSError *error) {
            NSLog(@"Error occured while exit %@", error);
        }

    });
}

@end
