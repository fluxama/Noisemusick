/*
 *  Sequence.h
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "cocos2d.h"

@interface Sequence : NSObject
{   
	int beats;
	int beat_count;
	int max_steps;
	int steps;
	int step_count;
	NSMutableArray *input_list;
}

@property int beats;
@property int beat_count;
@property int max_steps;
@property int steps;
@property int step_count;
@property (retain, nonatomic) NSMutableArray *input_list;

@end
