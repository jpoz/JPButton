//
//  AnimationPlayAppDelegate.h
//  AnimationPlay
//
//  Created by James Pozdena on 5/9/11.
//  Copyright 2011 James Pozdena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnimationPlayViewController;

@interface AnimationPlayAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet AnimationPlayViewController *viewController;

@end
