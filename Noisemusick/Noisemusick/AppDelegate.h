/*
 *  AppDelegate.h
 *  Noisemusick
 *
 *  Created by Shawn Wallace on 10/1/11.
 *  Copyright (c) 2011-2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */



#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "cocos2d.h"
#import "PdAudioController.h"
#import "PdDispatcher.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) PdAudioController *audioController;
@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;
-(void) turnOffSound;
-(void) turnOnSound;
//- (void) copyDemoPatchesToUserDomain;

@end
