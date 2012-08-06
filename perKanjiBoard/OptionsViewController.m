//
//  OptionsViewController.m
//  KanjiBoard
//
//  Created by apple on 22/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include "math.h"
#import "OptionsViewController.h"


@implementation OptionsViewController

@synthesize scrollView;
@synthesize jlpt1ScheduleDisplay, jlpt2ScheduleDisplay, jlpt3ScheduleDisplay, jlpt4ScheduleDisplay, jlpt5ScheduleDisplay, jlpt6ScheduleDisplay;
@synthesize jlpt1Slider, jlpt2Slider, jlpt3Slider, jlpt4Slider, jlpt5Slider, jlpt6Slider;
@synthesize jlptSchedule, managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Options";
        
    }
    return self;
}

-(IBAction)schedule:(id)sender {
    switch ([(UISlider *)sender tag]) {
        case 1:
            [jlpt1ScheduleDisplay setText:[NSString stringWithFormat:@"%.1f day(s)",jlpt1Slider.value]];
            [jlptSchedule setJlpt1:[NSNumber numberWithInt:(int)(jlpt1Slider.value)]];
            break;
        case 2:
            
            [jlpt2ScheduleDisplay setText:[NSString stringWithFormat:@"%.1f day(s)",jlpt2Slider.value]];
            [jlptSchedule setJlpt2:[NSNumber numberWithInt:(int)(jlpt2Slider.value)]];
            break;
        case 3:
            [jlpt3ScheduleDisplay setText:[NSString stringWithFormat:@"%.1f day(s)",jlpt3Slider.value]];
            [jlptSchedule setJlpt3:[NSNumber numberWithInt:(int)(jlpt3Slider.value)]];
            break;
        case 4:
            [jlpt4ScheduleDisplay setText:[NSString stringWithFormat:@"%.1f day(s)",jlpt4Slider.value]];
            [jlptSchedule setJlpt4:[NSNumber numberWithInt:(int)(jlpt4Slider.value)]];
            break;
        case 5:
            [jlpt5ScheduleDisplay setText:[NSString stringWithFormat:@"%.1f day(s)",jlpt5Slider.value]];
            [jlptSchedule setJlpt5:[NSNumber numberWithInt:(int)(jlpt5Slider.value)]];
            break;
        // BONUS
        case 6:
            [jlpt6ScheduleDisplay setText:[NSString stringWithFormat:@"%.1f day(s)",jlpt6Slider.value]];
            [jlptSchedule setSpecial:[NSNumber numberWithInt:(int)(jlpt6Slider.value)]];
            break;
        default:
            break;
    }
    NSError * error = nil;
    [managedObjectContext save:&error];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrollView.contentSize=CGSizeMake(320,640);
    
    jlpt1Slider.value = [jlptSchedule.jlpt1 doubleValue];
    jlpt2Slider.value = [jlptSchedule.jlpt2 doubleValue];
    jlpt3Slider.value = [jlptSchedule.jlpt3 doubleValue];
    jlpt4Slider.value = [jlptSchedule.jlpt4 doubleValue];
    jlpt5Slider.value = [jlptSchedule.jlpt5 doubleValue];
    jlpt6Slider.value = [jlptSchedule.special doubleValue];
    
    [jlpt1ScheduleDisplay setText:[NSString stringWithFormat:@"%.0f day(s)",jlpt1Slider.value]];
    [jlpt2ScheduleDisplay setText:[NSString stringWithFormat:@"%.0f day(s)",jlpt2Slider.value]];
    [jlpt3ScheduleDisplay setText:[NSString stringWithFormat:@"%.0f day(s)",jlpt3Slider.value]];
    [jlpt4ScheduleDisplay setText:[NSString stringWithFormat:@"%.0f day(s)",jlpt4Slider.value]];
    [jlpt5ScheduleDisplay setText:[NSString stringWithFormat:@"%.0f day(s)",jlpt5Slider.value]];
    [jlpt6ScheduleDisplay setText:[NSString stringWithFormat:@"%.0f day(s)",jlpt6Slider.value]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
