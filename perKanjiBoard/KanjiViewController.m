//
//  KanjiViewController.m
//  KanjiBoard
//
//  Created by apple on 21/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KanjiViewController.h"


@implementation KanjiViewController

@synthesize managedObjectContext;
@synthesize kanji, kanjiLabel, frequencyLabel;
@synthesize scrollView;
@synthesize masterdButton, resetButton, reviewButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Card";
        
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Flip" style:UIBarButtonItemStylePlain target:self action:@selector(flip)];           
        self.navigationItem.rightBarButtonItem = anotherButton;
        
    }
    return self;
}

- (void)dealloc
{
    [kanji release];
    [kanjiLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)mastered {
    [kanji setStatus:[NSNumber numberWithInt:1]];
    NSError * error = nil;
    [managedObjectContext save:&error];
    [frequencyLabel setBackgroundColor:[UIColor greenColor]];
}

- (IBAction)review {
    [kanji setStatus:[NSNumber numberWithInt:-1]];
    NSError * error = nil;
    [managedObjectContext save:&error];
    [frequencyLabel setBackgroundColor:[UIColor redColor]];
}

- (IBAction)reset {
    [kanji setStatus:[NSNumber numberWithInt:0]];
    NSError * error = nil;
    [managedObjectContext save:&error];
    [frequencyLabel setBackgroundColor:[UIColor whiteColor]];
}

- (void) flip {
    if (scrollView.hidden) {
        scrollView.hidden = false;
    }
    else {
        scrollView.hidden = true;
    }
}
     
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[masterdButton setBackgroundImage:[UIImage imageNamed:@"btn-green.png"] forState:UIControlStateNormal];
    //[reviewButton setBackgroundImage:[UIImage imageNamed:@"btn-red.png"] forState:UIControlStateNormal];
    //[masterdButton setBackgroundImage:[UIImage imageNamed:@"btn-selected.png"] forState:UIControlStateHighlighted];
    //[reviewButton setBackgroundImage:[UIImage imageNamed:@"btn-selected.png"] forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view from its nib.
    
    kanjiLabel.text = [kanji literal];
    
    //Construct meanings and readings strings
    NSString *meanings = @"";
    NSString *m = @"";
    NSInteger idxEnd = [[kanji meaning] count]-1;
    for (int i = 0; i<idxEnd; i++) {
        m = [(NSString *)[[kanji meaning] objectAtIndex:i] stringByAppendingString:@", "];
        meanings = [meanings stringByAppendingString:m];
    }
    meanings = [meanings stringByAppendingFormat:[[kanji meaning] objectAtIndex:idxEnd]];
    
    NSString *on_reading = @"";
    idxEnd = [[kanji reading_on] count]-1;
    for (int i = 0; i<idxEnd; i++) {
        m = [(NSString *)[[kanji reading_on] objectAtIndex:i] stringByAppendingString:@", "];
        on_reading = [on_reading stringByAppendingString:m];
    }
    @try {
        on_reading = [on_reading stringByAppendingString:[[kanji reading_on] objectAtIndex:idxEnd]];

    }
    @catch (NSException *exception) {
         
    }
    @finally {
         
    }
    NSString *kun_reading = @"";
    idxEnd = [[kanji reading_kun] count]-1;
    for (int i = 0; i<idxEnd; i++) {
        m = [(NSString *)[[kanji reading_kun] objectAtIndex:i] stringByAppendingString:@", "];
        kun_reading = [kun_reading stringByAppendingString:m];
    }
    @try {
        kun_reading = [kun_reading stringByAppendingString:[[kanji reading_kun] objectAtIndex:idxEnd]];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    //Display on_reading
    CGRect frame = CGRectMake(20, 160, 280, 200);
    UILabel *onReadingLabel = [[UILabel alloc] initWithFrame:frame];
    onReadingLabel.lineBreakMode = UILineBreakModeWordWrap;
    onReadingLabel.numberOfLines =0;
    [onReadingLabel setTextAlignment:UITextAlignmentCenter];
    [onReadingLabel setTextColor:[UIColor grayColor]];
    [onReadingLabel setText:on_reading];
    [onReadingLabel sizeToFit];
    [onReadingLabel setCenter:CGPointMake(160, onReadingLabel.frame.size.height/2 +25)];
    [self.scrollView addSubview:onReadingLabel];
    
    //Display kun_reading
    frame = CGRectMake(20, 160, 280, 200);
    UILabel *kunReadingLabel = [[UILabel alloc] initWithFrame:frame];
    kunReadingLabel.lineBreakMode = UILineBreakModeWordWrap;
    kunReadingLabel.numberOfLines =0;
    [kunReadingLabel setTextAlignment:UITextAlignmentCenter];
    [kunReadingLabel setTextColor:[UIColor grayColor]];
    [kunReadingLabel setText:kun_reading];
    [kunReadingLabel sizeToFit];
    [self.scrollView addSubview:kunReadingLabel];
    [kunReadingLabel setCenter:CGPointMake(160, onReadingLabel.center.y + onReadingLabel.frame.size.height/2 + kunReadingLabel.frame.size.height/2 + 10)];

    //Display meanings
    frame = CGRectMake(20, 160, 300, 200);
    UILabel *meaningLabel = [[UILabel alloc] initWithFrame:frame];
    meaningLabel.lineBreakMode = UILineBreakModeWordWrap;
    meaningLabel.numberOfLines =0;
    [meaningLabel setText:meanings];
    [meaningLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    [meaningLabel sizeToFit];
    [meaningLabel setCenter:CGPointMake(160,  kunReadingLabel.center.y + kunReadingLabel.frame.size.height/2 + meaningLabel.frame.size.height/2 + 20)];
    [self.scrollView addSubview:meaningLabel];
    
    scrollView.contentSize=CGSizeMake(320, 30 + meaningLabel.frame.origin.y - onReadingLabel.frame.origin.y + meaningLabel.frame.size.height);
    //Display freaquency
    frequencyLabel.text = [kanji.frequency stringValue];
    switch ([kanji.status integerValue]) {
        case 1:
            [frequencyLabel setBackgroundColor:[UIColor greenColor]];
            break;
        case -1:
            [frequencyLabel setBackgroundColor:[UIColor redColor]];
            break;
            
        default:
            break;
    }
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
