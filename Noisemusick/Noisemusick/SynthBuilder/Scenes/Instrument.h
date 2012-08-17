/*
 *  Instrument.h
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "PdDispatcher.h"
#import "PdAudioController.h"

@interface Instrument : NSObject {
	NSString *name;
	int type;
	int group;
	int instrument_id;
	int fluxalodeon_version;
    BOOL accelerometer_enabled;
	NSString *patch_name;
	NSMutableArray *interactive_inputs;
	NSMutableArray *sequences;
	NSString *about;
	NSString *help;
}

@property (copy, nonatomic) NSString *name;
@property int type;
@property int group;
@property int instrument_id;
@property int fluxalodeon_version;
@property BOOL accelerometer_enabled;
@property (copy, nonatomic) NSString *patch_name;
@property (retain, nonatomic) NSMutableArray *interactive_inputs;
@property (retain, nonatomic) NSMutableArray *sequences;
@property (copy, nonatomic) NSString *about;
@property (copy, nonatomic) NSString *help;

- (id) initWithName: (NSString *) instrumentName;

@end