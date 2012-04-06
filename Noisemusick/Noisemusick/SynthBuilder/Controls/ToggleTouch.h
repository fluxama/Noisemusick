/*
 *  TouchArea.h
 *  Noisemusick
 *
 *  Created by Shawn Wallace on 4/30/11.
 *  Copyright (c) 2011-2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "cocos2d.h"
#import "Control.h"
#import "PdDispatcher.h"

@interface ToggleTouch : Control
{   
    float touch_controlx;
    float touch_controly;
    NSString *touch_patch_inputx;
    NSString *touch_patch_inputy;
}

-(id) initWithDictionary: (NSDictionary *) params;
- (void) updateView:(CGPoint) location;
-(void) sendControlValues;
- (void) showHighlight;
- (void) hideHighlight;
- (void) showSeqHighlight;
- (void) hideSeqHighlight;
- (void) dealloc;

@end
