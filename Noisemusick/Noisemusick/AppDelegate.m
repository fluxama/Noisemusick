/*
 *  AppDelegate.m
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */



#import "AppDelegate.h"
#import "MenuScene.h"
#import "cocos2d.h"

@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;
@synthesize audioController = _audioController;
@synthesize audiobusController = _audiobusController;
@synthesize audiobusAudioUnitWrapper = _audiobusAudioUnitWrapper;

void lookup_tilde_setup(); 
void kink_tilde_setup();
void gate_setup();
void comb_tilde_setup();
void tanh_tilde_setup();

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    current_item = 0;
    
    if (IS_IPAD) {
        THUMBW = 789;
        THUMBH = 539;
        PADW = 40;
        SCREEN_CENTER_X = 512;
        SCREEN_CENTER_Y = 384;
        BUTTON_Y = 60;
        ABOUT_IMAGE_WIDTH = 1000;
        HELP_SCREEN_H = 1394;
        INFO_ICON_H = 181;
    } else if (IS_IPHONE_5) {
            THUMBW = 370;
            THUMBH = 253;
            PADW = 40;
            SCREEN_CENTER_X = 284;
            SCREEN_CENTER_Y = 160;
            BUTTON_Y = 30;
            ABOUT_IMAGE_WIDTH = 1000;
            HELP_SCREEN_H = 654;
            INFO_ICON_H = 86;

    } else {
        THUMBW = 370;
        THUMBH = 253;
        PADW = 20;
        SCREEN_CENTER_X = 240;
        SCREEN_CENTER_Y = 160;
        BUTTON_Y = 30;
        ABOUT_IMAGE_WIDTH = 1000;
        HELP_SCREEN_H = 654;
        INFO_ICON_H = 86;
    }
    
    // Turn off idle timer
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
                            preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
    [glView setMultipleTouchEnabled:YES];
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

	director_.wantsFullScreenLayout = YES;
    
    // enable multi touch
    [glView setMultipleTouchEnabled:YES];
    
    // Display FSP and SPF
	[director_ setDisplayStats:NO];

	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];

	// attach the openglView to the director
	[director_ setView:glView];

	// for rotation and other messages
	[director_ setDelegate:self];
    
    
	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
//	[director setProjection:kCCDirectorProjection3D];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	//if( ! [director_ enableRetinaDisplay:YES] )
	//	CCLOG(@"Retina Display Not supported");

	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;

    // set the Navigation Controller as the root view controller
	[window_ setRootViewController:navController_];

	// make main window visible
	[window_ makeKeyAndVisible];

   // MPVolumeSettingsAlertShow();

	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
    
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    
    _audioController = [[PdAudioController alloc] init];
    if ([self.audioController configurePlaybackWithSampleRate:44100
                                               numberChannels:2
                                                 inputEnabled:NO
                                                mixingEnabled:YES] != PdAudioOK) {
        NSLog(@"failed to initialize audio components");
    }
    lookup_tilde_setup();
    kink_tilde_setup();
    gate_setup();
    comb_tilde_setup();
    tanh_tilde_setup();
    
    self.audioController.active = YES;
    
    // Turn on Audiobus support
    self.audiobusController = [[[ABAudiobusController alloc]
                                initWithAppLaunchURL:[NSURL URLWithString:@"noisemusick.audiobus://"]
                        apiKey:@"MCoqKk5vaXNlbXVzaWNrKioqbm9pc2VtdXNpY2suYXVkaW9idXM6Ly8=:CrOIuVYViTv/VJlBOfKYuA/XaZZJ6GFWNKIucvkha1iYMYAbGvfoW1YPR11gdsOt+JMzIJlxo7RgxcLTflZRfmDGJBZaX8dlRhkjIpQwhFYO4ZcIkCHJqc0+MbHW7O2K"]
                               autorelease];
    // May need this if menus collide:
    //self.audiobusController.connectionPanelPosition = ABAudiobusConnectionPanelPositionLeft;
    
    ABOutputPort *output = [self.audiobusController addOutputPortNamed:@"Audio Output"
                                                                 title:NSLocalizedString(@"Main App Output", @"")];
    
    self.audiobusAudioUnitWrapper = [[[ABAudiobusAudioUnitWrapper alloc]
                                      initWithAudiobusController:self.audiobusController
                                      audioUnit:_audioController.audioUnit.audioUnit
                                      output:output
                                      input:nil] autorelease];
    
    void *ptr = [PdBase openFile:@"pd-Noisemusick.pd"
                            path:[[NSBundle mainBundle] resourcePath]];
    if (!ptr) { 
        NSLog(@"Failed to open patch!");
    }
    [PdBase sendFloat:0.0f toReceiver:@"kit_number"];
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	//[director_ pushScene:ms]; 
    MenuScene *ms = [MenuScene node];
    [director_ pushScene:ms];
   // [[CCDirector sharedDirector] runWithScene:ms];

	return YES;
}

- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

// NOT CALLED IN iOS6?? Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    //return YES;
}

-(void) turnOffSound {
    self.audioController.active = NO;
}

-(void) turnOnSound {
    self.audioController.active = YES;
}

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
    // Turn on idle timer
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    if (holdOn == 0)
        self.audioController.active = NO;
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
    self.audioController.active = YES;

 	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) dealloc
{
	[window_ release];
    self.audioController = nil;
    //[_audioController release];
	[navController_ release];

	[super dealloc];
}
@end
