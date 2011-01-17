//
//  DemoAppDelegate.h
//  Demo
//
//  Created by Alex Leutgöb on 17.01.11.
//  Copyright 2011 alexleutgoeb.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemoViewController;

@interface DemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DemoViewController *viewController;

@end

