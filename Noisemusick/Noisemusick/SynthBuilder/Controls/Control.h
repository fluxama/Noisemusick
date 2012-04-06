/*
 *  Control.h
 *  Noisemusick
 *
 *  Created by Shawn Wallace on 10/1/11.
 *  Copyright (c) 2011-2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */

#import "cocos2d.h"
#import "PdDispatcher.h"

@interface Control : CCNode 
{   
	NSString *control_id;
	int control_type;
	int control_x;
	int control_y;
	int control_width;
	int control_height;
	float control_scale;
	float control_angle;
	float control_value;
    int control_state;
	NSString *control_patch_input;
    int control_linked_to_output;
	int control_linked_to_seq_bpm;
	int control_linked_to_seq_length;
	int control_sequenced_by;
	int control_step_num;
	CCSprite *sprite;
	CCSprite *sprite_highlight;
	CCSprite *sprite_seq_highlight;
}

@property (copy, nonatomic) NSString *control_id;
@property int control_type;
@property int control_x;
@property int control_y;
@property int control_width;
@property int control_height;
@property float control_scale;
@property float control_angle;
@property float control_value;
@property int control_state;
@property (copy, nonatomic) NSString *control_patch_input;
@property int control_linked_to_output;
@property int control_linked_to_seq_bpm;
@property int control_linked_to_seq_length;
@property int control_sequenced_by;
@property int control_step_num;

-(id) initWithDictionary: (NSDictionary *) params;
-(BOOL) withinBounds:(CGPoint) location;
-(void) tick: (ccTime) dt;
-(void) touchAdded:(UITouch *) touch;
-(void) touchRemoved:(UITouch *) touch;
-(void) sendControlValues;
-(void) sendZeroValues;
-(void) sendOnValues;
-(void) sendOffValues;
-(void) sendControlValuesForTouch:(UITouch *) touch;
- (void) updateView:(CGPoint) location;
- (void) showHighlight;
- (void) hideHighlight;
- (void) showSeqHighlight;
- (void) hideSeqHighlight;

@end
