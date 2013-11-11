/*
 *  Control.m
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "Control.h"

@implementation Control

@synthesize control_id;
@synthesize control_type;
@synthesize control_x;
@synthesize control_y;
@synthesize control_width;
@synthesize control_height;
@synthesize control_scale;
@synthesize control_angle;
@synthesize control_value;
@synthesize control_state;
@synthesize control_patch_input;
@synthesize control_linked_to_output;
@synthesize control_linked_to_seq_bpm;
@synthesize control_linked_to_seq_length;
@synthesize control_sequenced_by;
@synthesize control_step_num;

-(id) initWithDictionary: (NSDictionary *) params {
	if( (self=[super init] )) {
		self.control_id = [params objectForKey:@"input_id"];
		self.control_type = [[params objectForKey:@"input_type"] intValue];
        if (IS_IPAD) {
            // Scale and offset position
            self.control_x = [[params objectForKey:@"x"] intValue]*IPAD_MULT;
            self.control_y = [[params objectForKey:@"y"] intValue]*IPAD_MULT + IPAD_BOT_TRIM;
            self.control_width = [[params objectForKey:@"width"] intValue]*IPAD_MULT;
            self.control_height = [[params objectForKey:@"height"] intValue]*IPAD_MULT;
        } else if (IS_IPHONE_5) {
            self.control_x = [[params objectForKey:@"x"] intValue]+IPHONE_5_MARGIN;
            self.control_y = [[params objectForKey:@"y"] intValue];
            self.control_width = [[params objectForKey:@"width"] intValue];
            self.control_height = [[params objectForKey:@"height"] intValue];
        } else {
            self.control_x = [[params objectForKey:@"x"] intValue];
            self.control_y = [[params objectForKey:@"y"] intValue];
            self.control_width = [[params objectForKey:@"width"] intValue];
            self.control_height = [[params objectForKey:@"height"] intValue]; 
        }
		self.control_scale = [[params objectForKey:@"scale"] floatValue];
		self.control_angle = [[params objectForKey:@"angle"] floatValue];
		self.control_value = [[params objectForKey:@"value"] floatValue];
		self.control_state = [[params objectForKey:@"state"] intValue];
		self.control_patch_input = [params objectForKey:@"patch_input"];
		self.control_linked_to_output = [[params objectForKey:@"linked_to_output"] intValue ];
		self.control_linked_to_seq_bpm = [[params objectForKey:@"linked_to_seq_bpm"] intValue ];
		self.control_linked_to_seq_length = [[params objectForKey:@"linked_to_seq_length"] intValue ];
		self.control_sequenced_by = [[params objectForKey:@"sequenced_by"] intValue];
		self.control_step_num = [[params objectForKey:@"step_num"] intValue];
	}
	return self;
}

-(BOOL) withinBounds:(CGPoint) location {
	if ((location.x < self.position.x+control_scale*(control_width/2)) &&
		(location.x > self.position.x-control_scale*(control_width/2)) &&
		(location.y < self.position.y+control_scale*(control_height/2)) &&
		(location.y > self.position.y-control_scale*(control_height/2))) {
		return TRUE;
	} else {
		return FALSE;
	}
}

-(void) tick: (ccTime) dt { 
}

-(void) touchAdded:(UITouch *) touch { 
}

-(void) touchRemoved:(UITouch *) touch { 
}

-(void) sendControlValues {
    //CCLOG(@"%@ %3.3f",self.control_patch_input, self.control_value);
    [PdBase sendFloat:self.control_value toReceiver:self.control_patch_input];
}

-(void) sendOnValues {
   // CCLOG(@"%@ ON",[NSString stringWithFormat:@"%@OFF",self.control_id]);
    [PdBase sendFloat:1 toReceiver:[NSString stringWithFormat:@"%@OFF",self.control_id]];
}

-(void) sendZeroValues {
    // CCLOG(@"%@ zeroed",self.control_patch_input);
    [PdBase sendFloat:0 toReceiver:self.control_patch_input];
}

-(void) sendOffValues {
   // CCLOG(@"%@ OFF",[NSString stringWithFormat:@"%@OFF",self.control_id]);
    [PdBase sendFloat:0 toReceiver:[NSString stringWithFormat:@"%@OFF",self.control_id]];
}

-(void) sendControlValuesForTouch:(UITouch *) touch {
}

-(void) updateView:(CGPoint) location {	
}

- (void) showHighlight {
}

- (void) hideHighlight {
}

- (void) showSeqHighlight {
}

- (void) hideSeqHighlight {
 }

- (void) dealloc {
    // CCLOG(@"Dealloc Control");
    [control_id release];
	[control_patch_input release];
    [super dealloc];
    
}



@end