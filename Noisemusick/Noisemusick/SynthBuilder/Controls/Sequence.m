/*
 *  Sequence.m
 *  Noisemusick
 *
 *  Created by Shawn Wallace on 4/23/11.
 *  Copyright (c) 2011-2012 by Shawn Wallace of the Fluxama Group. 
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