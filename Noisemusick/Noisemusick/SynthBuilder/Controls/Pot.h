/*
 *  Pot.h
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

@interface Pot : Control
{   
	float control_min;
	float control_max;
	float control_step;
	float control_start_angle;
	float control_sweep_angle;
    float prevAngle;
    bool pinnedLow;
    bool pinnedHigh;
    bool crossedLowClockwise;
    bool crossedLowCC;
    bool crossedHighClockwise;
    bool crossedHighCC;
}

@property float control_min;
@property float control_max;
@property float control_step;
@property float control_start_angle;
@property float control_sweep_angle;

- (id) initWithDictionary: (NSDictionary *) params;
- (void) updateView:(CGPoint) location;
- (void) showHighlight;
- (void) hideHighlight;
- (void) showSeqHighlight;
- (void) hideSeqHighlight;

@end
