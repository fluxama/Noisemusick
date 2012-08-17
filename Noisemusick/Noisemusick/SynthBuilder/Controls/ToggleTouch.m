/*
 *  TouchArea.m
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "ToggleTouch.h"

@implementation ToggleTouch

-(id) initWithDictionary: (NSDictionary *) params {
	if( (self=[super initWithDictionary: params] )) {
        touch_patch_inputx = [[NSString alloc] init];
        touch_patch_inputy =  [[NSString alloc] init];
        touch_patch_inputx = [params objectForKey:@"touch_patch_inputx1"];
        touch_patch_inputy =[params objectForKey:@"touch_patch_inputy1"];
        [touch_patch_inputx retain];
        [touch_patch_inputy retain];
	}
	return self;
}

-(void) updateView:(CGPoint) location {
    float d1 = location.y-self.position.y;
     float d2 = location.x-self.position.x;
     float r = sqrt(pow(d1,2) + pow(d2,2));
     float angle=0;
     if (r>0) {
         angle = asin(d1/r);
         if (location.x > self.position.x)  {
             angle = 3.1415f - angle;
         } 
         if ((location.x < self.position.x) && (location.y < self.position.y))  {
             angle = 6.283f + angle;
         } 
     }
     
    // the following sends x and y instead of r and angle:
    //touch_controlx = (location.x - self.control_x + self.control_width/2)/self.control_width;
    //touch_controly = (location.y - self.control_y + self.control_height/2)/self.control_height;
    
    touch_controlx = angle/6.283f;
    touch_controly = r/100.0;
}

-(void) sendControlValues {
    //CCLOG(@"%@ x %3.3f",touch_patch_inputx, self.control_value);
    //CCLOG(@"%@ y %3.3f",touch_patch_inputy, self.control_value);
    [PdBase sendFloat:1 toReceiver:[NSString stringWithFormat:@"%@OFF",self.control_id]];
    [PdBase sendFloat:touch_controlx toReceiver:touch_patch_inputx];
    [PdBase sendFloat:touch_controly toReceiver:touch_patch_inputy];
}

- (void) showHighlight {
    sprite_highlight.visible = YES;
}

- (void) hideHighlight {
    sprite_highlight.visible = NO;
}

- (void) showSeqHighlight {
    sprite_seq_highlight.visible = YES;
}

- (void) hideSeqHighlight {
    sprite_seq_highlight.visible = NO;
}

- (void) dealloc {
    // CCLOG(@"Dealloc Touch Area");
    [touch_patch_inputx release];
    [touch_patch_inputy release];
    [super dealloc];
}
@end
