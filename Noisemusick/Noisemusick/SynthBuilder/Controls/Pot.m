/*
 *  Pot.m
 *  Noisemusick
 *  http://www.fluxama.com
 *  http://github.com/fluxama
 *
 *  Created by Elliot Clapp, Shawn Greenlee, and Shawn Wallace
 *  Copyright (c) 2012 by Shawn Wallace of the Fluxama Group. 
 *  For information on usage and redistribution, and for a DISCLAIMER OF ALL
 *  WARRANTIES, see the file, "Noisemusick-LICENSE.txt," in this distribution.  */

#import "Pot.h"

@implementation Pot

@synthesize control_min;
@synthesize control_max;
@synthesize control_step;
@synthesize control_start_angle;
@synthesize control_sweep_angle;

-(id) initWithDictionary: (NSDictionary *) params {
	if( (self=[super initWithDictionary: params] )) {
		
		self.control_min = [[params objectForKey:@"min"] floatValue];
		self.control_max = [[params objectForKey:@"max"] floatValue];
		self.control_step = [[params objectForKey:@"step"] floatValue];
		self.control_start_angle = [[params objectForKey:@"start_angle"] floatValue];
		self.control_sweep_angle = [[params objectForKey:@"sweep_angle"] floatValue];
		self.control_value = [[params objectForKey:@"value"] floatValue];

        pinnedLow = NO;
        pinnedHigh = NO;
        
		sprite = [CCSprite spriteWithFile:@"knobLine.png"];
		sprite.position = ccp(0, 0);
		sprite.visible = YES;
		[self addChild:sprite z:3];
        CCSprite *top = [CCSprite spriteWithFile:@"KnobTop.png"];
        //[top setBlendFunc: (ccBlendFunc) { GL_SRC_ALPHA, GL_ONE }];
		top.position = ccp(0, 0);
		top.visible = YES;
		[self addChild:top z:4];
		sprite_highlight = [CCSprite spriteWithFile:@"RingWhite.png"];
		sprite_highlight.position = ccp(0, 0);
		sprite_highlight.visible = NO;
        [sprite setRotation:CC_RADIANS_TO_DEGREES(5.01f)];
        [sprite_highlight setRotation:CC_RADIANS_TO_DEGREES(5.01f)];
		[self addChild:sprite_highlight z:5];
        prevAngle = 5;
	}
	return self;
}

-(void) updateView:(CGPoint) location {
	float d1 = location.y-self.position.y;
	float d2 = location.x-self.position.x;
	float r = sqrt(pow(d1,2) + pow(d2,2));
	if (r>0) {
		float angle = asin(d1/r);

		if (location.x > self.position.x)  {
			angle = 3.1415f - angle;
        } 
        if ((location.x < self.position.x) && (location.y < self.position.y))  {
            angle = 6.283f + angle;
        } 
        
        //CCLOG(@"Angle: %3.3f", angle);
        
        if ((prevAngle>3)&&(prevAngle<=4)&&(angle>4)&&(angle<5)) {
            crossedHighClockwise = YES;
        }
        if ((prevAngle>=4)&&(prevAngle<5)&&(angle<4)&&(angle>3)) {
            crossedHighCC = YES;
        } 
        if ((prevAngle>4)&&(prevAngle<=5)&&(angle>5)&&(angle<6)) {
            crossedLowClockwise = YES;
        }
        if ((prevAngle>=5)&&(prevAngle<6)&&(angle<5)&&(angle>4)) {
            crossedLowCC = YES;
        } 
        if (pinnedHigh && crossedHighCC) {
            pinnedHigh = NO;
            crossedHighCC = NO;
        }
        
        if (pinnedLow && crossedLowClockwise) {
            pinnedLow = NO;
            crossedLowClockwise=NO;
        }
        
        // Can't remember what cases these satisfy...
        if ((prevAngle>=5)&&(angle>5)&&(angle<6)) {
            pinnedLow = NO;
        }
        if ((angle<4)&&(prevAngle<4)) {
            pinnedHigh = NO;
        } 

        // map value here
        
        if (pinnedHigh || crossedHighClockwise) {
            angle = 4;
            pinnedHigh = YES;
            crossedHighClockwise=NO;
        }
        
        if (pinnedLow || crossedLowCC) {
            angle = 5;
            pinnedLow = YES;
            crossedLowCC = NO;
        }
         
        prevAngle = angle;
        float value;
        if (angle >= 5) {
            value = angle-5;
        } else {
            value = (angle+1.283f);
        }
        self.control_value = (value / 5.283f);
        
        //CCLOG(@"CV: %3.3f", self.control_value);
        [sprite setRotation:CC_RADIANS_TO_DEGREES(angle)];
        [sprite_highlight setRotation:CC_RADIANS_TO_DEGREES(angle)];
	}
}

- (void) showHighlight {
    sprite_highlight.visible = YES;
}

- (void) hideHighlight {
    sprite_highlight.visible = NO;
}

- (void) showSeqHighlight {
}

- (void) hideSeqHighlight {
}

-(void) touchRemoved:(UITouch *) touch { 
    crossedLowCC = NO;
    crossedLowClockwise=NO;
    crossedHighCC = NO;
    crossedHighClockwise=NO;
}

- (void) dealloc {
    // CCLOG(@"Dealloc Pot");
    [super dealloc];
    
}

@end
