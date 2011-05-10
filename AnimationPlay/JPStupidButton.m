//
//  JPStupidButton.m
//  AnimationPlay
//
//  Created by James Pozdena on 5/9/11.
//  Copyright 2011 James Pozdena. All rights reserved.
//

#import "JPStupidButton.h"

@interface JPStupidButton()

- (void)setupLayers;
- (void)animateDown;
- (void)animateUp;
- (void)animateStick;

@end


@implementation JPStupidButton

int const JPStupidButtonPopMode = 1;
int const JPStupidButtonStickMode = 2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setMode:(int)mode
{
    buttonMode = mode;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setMode:JPStupidButtonPopMode];
        state = 0;
        [self setupLayers];
    }
    return self;
}

- (void)setupLayers {
    
    CGRect base_bounds = CGRectMake(0, 0, self.layer.bounds.size.width, self.layer.bounds.size.height - self.layer.bounds.size.height * 0.10f);
    
    CGPoint move_point = CGPointMake(0.0f, base_bounds.size.height * 0.10f);
    
    self.layer.masksToBounds = NO;
    
    baseLayer = [CALayer layer];
    
    baseLayer.cornerRadius = 10.0;
    baseLayer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    baseLayer.shadowOpacity = 1.5f;
    baseLayer.shadowColor = [UIColor blackColor].CGColor;
    baseLayer.shadowRadius = 2.5f;
    baseLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    baseLayer.position    = move_point;
    
    CAShapeLayer *shape = [CALayer layer];
    shape.bounds = base_bounds;
    shape.cornerRadius = 10.0;
    shape.anchorPoint      = CGPointMake(0.0f, 0.0f);
    shape.position         = move_point;
    shape.backgroundColor = [UIColor darkGrayColor].CGColor;
    
    gradient = [CAGradientLayer layer];
    gradient.anchorPoint      = CGPointMake(0.0f, 0.0f);
    gradient.position         = CGPointMake(0.0f, 0.0f);
    gradient.bounds           = base_bounds;
    gradient.cornerRadius     = 10.0;
    gradient.borderColor      = [UIColor colorWithRed:0.72f
                                                green:0.72f
                                                 blue:0.72f
                                                alpha:1.0].CGColor;
    gradient.borderWidth      = 0.73;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:0.82f
                                           green:0.82f
                                            blue:0.82f
                                           alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:0.52f
                                           green:0.52f
                                            blue:0.52f
                                           alpha:1.0].CGColor,
                       nil];
    
    CATextLayer *textLayer = [CATextLayer layer];
//    [textLayer bind:@"string" toObject:self withKeyPath:@"titleLabel" options:nil];
    [textLayer setString:self.titleLabel.text]; 
    
    NSLog(@"String %@", self.titleLabel.text);
    
    [textLayer setFont:@"Menlo"];
    [textLayer setFontSize:15.0f];
    [textLayer setForegroundColor:[UIColor darkGrayColor].CGColor];
    [textLayer setShadowColor:[UIColor lightGrayColor].CGColor];
    [textLayer setShadowOpacity:9.0f];
    [textLayer setShadowRadius:.5];
    [textLayer setShadowOffset:CGSizeMake(1.0, 1.0)];
    [textLayer setBounds:gradient.bounds];
    [textLayer setAnchorPoint:CGPointMake(-0.1, -0.1)];
    [textLayer setPosition:CGPointMake(0.0, 0.0)];
    
    [gradient addSublayer:textLayer];
    
    [baseLayer addSublayer:shape];
    [baseLayer addSublayer:gradient];
    [self.layer addSublayer:baseLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch(state)
    {
        case 0:
            state = 1;
            break;
        default:
            state = 0;
            break;
    }
    [self animateDown];    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch(buttonMode)
    {
        case 1:
            [self animateUp];
            break;
        case 2:
            if (state == 1) {
                [self animateStick];
            } else {
                [self animateUp];
            }
            break;
        default:
            break;
    }
    
}

- (void)animateDown
{
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:0.7f
                                           green:0.7f
                                            blue:0.82f
                                           alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:0.4f
                                           green:0.4f
                                            blue:0.52f
                                           alpha:1.0].CGColor,
                       nil];
    gradient.position         = CGPointMake(0.0f, self.layer.bounds.size.height * 0.10f);
}

- (void)animateUp
{
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:0.82f
                                           green:0.82f
                                            blue:0.82f
                                           alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:0.52f
                                           green:0.52f
                                            blue:0.52f
                                           alpha:1.0].CGColor,
                       nil];
    gradient.position         = CGPointMake(0.0f, 0.0f);
}

- (void)animateStick
{
    gradient.position         = CGPointMake(0.0f, self.layer.bounds.size.height * 0.07f);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
