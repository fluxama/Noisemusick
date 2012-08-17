/*
 *  TouchArea.h
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
