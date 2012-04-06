/*
 *  InstrumentScene.h
 *  Noisemusick
 *
 *  Created by Shawn Wallace on 10/1/11.
 *  Copyright (c) 2011-2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "cocos2d.h"
#import "Control.h"
#import "PdDispatcher.h"
#import "PdAudioController.h"
#import "NavMenu.h"

@class InstrumentLayer;

// Instrument Layer
@interface InstrumentScene : CCScene
{
	NSString *instrument_name;
	InstrumentLayer *layer;
    CCLayer *helpLayer;
    CCMenu *helpMenu;
    NavMenu *nav_menu;
}
-(void) loadInstrument;
- (void) toggleHelp: (id)sender;

@property (copy, nonatomic) NSString *instrument_name;

@end

@interface InstrumentLayer : CCLayer 
{
    //NSValue *fileReference;
   //PdDispatcher *dispatcher;
    NSUInteger touchCount;
    CFMutableDictionaryRef touchList;
    CCSprite *LEDLayer;
    bool LEDState;
    float beat_count;
    float beats;
    int padsTouched;
    bool screenIsTouched;
}   

- (void) loadInstrument: (NSString *) name;
- (void) openPatch:(NSString *) patch;
- (void) closePatch;
-(void) toggleHelp: (id)sender;

//@property (nonatomic, retain) PdAudioController *audioController;
//@property (nonatomic, retain) NSValue *fileReference;

@end
