/*
 *  Sequence.m
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */

#import "Sequence.h"

@implementation Sequence

@synthesize beats;
@synthesize beat_count;
@synthesize max_steps;
@synthesize steps;
@synthesize step_count;
@synthesize input_list;

-(id) init {
	if( (self=[super init] )) {
		beat_count = 0;
		step_count = 0;
	}
	return self;
}

- (void) dealloc {
    //CCLOG(@"Dealloc Sequence");
    [input_list dealloc];
    [super dealloc];
}

@end