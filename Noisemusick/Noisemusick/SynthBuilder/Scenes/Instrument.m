/*
 *  Instrument.m
 *  Noisemusick
 *
 *  Created by Shawn Wallace on 10/1/11.
 *  Copyright (c) 2011-2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */


#import "cocos2d.h"
#import "Instrument.h"
#import "Control.h"
#import "Sequence.h"
#import "Pot.h"
#import "ToggleTouch.h"
#import "TwoPosSwitch.h"

@implementation Instrument

@synthesize name;
@synthesize type;
@synthesize group;
@synthesize instrument_id;
@synthesize fluxalodeon_version;
@synthesize accelerometer_enabled;
@synthesize patch_name;
@synthesize interactive_inputs;
@synthesize sequences;
@synthesize about;
@synthesize help;

- (id) initWithName: (NSString *) instrumentName {
	
    self = [super init];
    if (self) {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
																  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", instrumentName]];
		//CCLOG(@"Path: %@",plistPath);
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:instrumentName ofType:@"plist"];
        }
		//CCLOG(@"Path: %@",plistPath);
		
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
											  propertyListFromData:plistXML
											  mutabilityOption:NSPropertyListMutableContainersAndLeaves
											  format:&format
											  errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        self.name = [temp objectForKey:@"name"];
		self.type = [[temp objectForKey:@"type"] intValue];
		self.group = [[temp objectForKey:@"group"] intValue];
		self.instrument_id = [[temp objectForKey:@"instrument_id"] intValue];
		self.fluxalodeon_version = [[temp objectForKey:@"fluxalodeon_version"] intValue];
        self.accelerometer_enabled = [[temp objectForKey:@"accelerometer_enabled"] boolValue];
		self.patch_name = [temp objectForKey:@"patch_name"];
		self.about = [temp objectForKey:@"about"];
		self.help = [temp objectForKey:@"help"];
        
        [PdBase sendFloat:self.type  toReceiver:@"kit_number"];

		// Read in inputs
		NSMutableArray *list = [NSMutableArray arrayWithArray:[temp objectForKey:@"interactive_inputs"]];
		
		interactive_inputs = [[NSMutableArray alloc] init]; 
		for (int i=0; i<[list count]; i++) {
			NSDictionary *dict = [list objectAtIndex:i];
			int control_type = [[dict objectForKey:@"input_type"] intValue];

			switch (control_type) {
				case POT1 : 
				{ 
					Pot *c = [[Pot alloc] initWithDictionary:dict];
					[interactive_inputs addObject:c];
                    c.scale = c.control_scale;
                    [c autorelease];
                    [c sendControlValues];
					break;
				}
                case TOGGLE_TOUCH : 
				{
					ToggleTouch *ta = [[ToggleTouch alloc] initWithDictionary:dict];
					[interactive_inputs addObject:ta];
                    ta.scale = ta.control_scale;
                    [ta autorelease];
                    
                    [ta sendControlValues];
                    [ta sendOffValues];
					break;
				}
                case TWO_POS_SWITCH :
                {
					TwoPosSwitch *s = [[TwoPosSwitch alloc] initWithDictionary:dict];
					[interactive_inputs addObject:s];
                    s.scale = s.control_scale;
                    [s autorelease];
                    [s sendControlValues];
					break;
				}
            }
		}

		// Read in sequences
		NSMutableArray *seq_list = [NSMutableArray arrayWithArray:[temp objectForKey:@"sequences"]];
		sequences = [[NSMutableArray alloc] init]; 
        
		for (int i=0; i < [seq_list count]; i++) {
			Sequence *s = [[Sequence alloc] init];
			s.beats = [[[seq_list objectAtIndex:i] objectForKey:@"beats"] intValue];
			s.max_steps = [[[seq_list objectAtIndex:i] objectForKey:@"max_steps"] intValue];
			s.steps = [[[seq_list objectAtIndex:i] objectForKey:@"steps"] intValue];
            s.input_list = [[NSMutableArray alloc] init]; 
            [s.input_list addObjectsFromArray:[[seq_list objectAtIndex:i] objectForKey:@"input_list"]];
			[sequences addObject:s];
            [s autorelease];
		}
    }
    return self;
}

- (void) dealloc {
    //CCLOG(@"Dealloc Instrument");
    [interactive_inputs dealloc];
    [sequences dealloc];
    [name release];
    [patch_name release];
    [about release];
    [help release];
    [super dealloc];
}

@end