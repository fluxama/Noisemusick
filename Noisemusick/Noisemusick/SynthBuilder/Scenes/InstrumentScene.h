/*
 *  InstrumentScene.h
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "cocos2d.h"
#import "Control.h"
#import "PdDispatcher.h"
#import "PdAudioController.h"
#import "NavMenu.h"
#import "HelpLayer.h"

@class InstrumentLayer;

// Instrument Layer
@interface InstrumentScene : CCScene
{
	NSString *instrument_name;
	InstrumentLayer *layer;
    CCLayer *infoLayer;
    CCMenu *infoMenu1;
    CCMenu *infoMenu2;
    CCMenu *exitButtonMenu;
    NavMenu *nav_menu;
}
-(void) loadInstrument;
- (void) toggleHelp: (id)sender;
- (void) toggleInfo: (id)sender;
- (void) gotoNM: (id)sender;
- (void) gotoDrom: (id)sender;
- (void) gotoFB: (id)sender;
- (void) gotoTwitter: (id)sender;
- (void) gotoWeb: (id)sender;

@property (copy, nonatomic) NSString *instrument_name;

@end

@interface InstrumentLayer : CCLayer 
{
    //NSValue *fileReference;
   //PdDispatcher *dispatcher;
    NSUInteger touchCount;
    CFMutableDictionaryRef touchList;
    CCSprite *LEDLayer;
    CCMenu *helpMenu;
    HelpLayer *helpLayer;
    bool LEDState;
    float beat_count;
    float beats;
    int padsTouched;
    bool screenIsTouched;
}   

- (void) loadInstrument: (NSString *) name;
- (void) openPatch:(NSString *) patch;
- (void) closePatch;
- (void) toggleHelp: (id)sender;

//@property (nonatomic, retain) PdAudioController *audioController;
//@property (nonatomic, retain) NSValue *fileReference;

@end
