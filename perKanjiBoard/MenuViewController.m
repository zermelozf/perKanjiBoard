//
//  MenuViewController.m
//  KanjiBoard
//
//  Created by apple on 20/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "KanjiListViewController.h"
#import "OptionsViewController.h"
#import "MenuTableViewController.h"
#import "AboutViewController.h"


@implementation MenuViewController

@synthesize managedObjectContext, kanjiList, jlptSchedule, spinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Menu";
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
        self.view.backgroundColor = background;
        
        MenuTableViewController * menuTV = [[MenuTableViewController alloc] initWithNibName:@"MenuTableViewController" bundle:nil];
        [menuTV.view setFrame:CGRectMake(10, 10, 200, 590)];
        [menuTV.view setCenter:CGPointMake(160 , 320)];
        menuTV.daddy = self;
        [self.view addSubview:[menuTV view]];
        
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner setFrame:CGRectMake(0, 0, 35, 35)];
        [spinner setCenter:CGPointMake(160, 160)];
        [self.view addSubview:spinner];
        [spinner release];
    } 
    return self;
}

-(void)threadStartAnimating {
    [spinner startAnimating];
}

-(void)toList:(NSInteger)level
{
    // Fetch Kanji
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating) toTarget:self withObject:nil];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Kanji" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"frequency" ascending:YES];
    //if (level == 6) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"heisigFrequency" ascending:YES];
    //}
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    [sortDescriptors release];
    [sortDescriptor release];
    
    if (level != 6) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"level == %@", [NSNumber numberWithInt:level]];
        [request setPredicate:predicate];
    }
    
    NSError *error = nil;
    kanjiList = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    // Fetch Schedule
    request = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"JLPTSchedule" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    jlptSchedule = [[managedObjectContext executeFetchRequest:request error:&error] lastObject];
    
    // Push new View
    KanjiListViewController *kanjiListVC = [[KanjiListViewController alloc] initWithNibName:@"KanjiListViewController" list:kanjiList jlptLevel:level];
    kanjiListVC.jlptLevel = level;
    kanjiListVC.managedObjectContext = managedObjectContext;
    kanjiListVC.jlptSchedule = jlptSchedule;
    [self.navigationController pushViewController:kanjiListVC animated:YES];
    [spinner stopAnimating];
    [kanjiListVC release];
    [request release];
    [entity release];
}

-(void)toOptions {
    // Fetch Schedule
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"JLPTSchedule" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    jlptSchedule = [[managedObjectContext executeFetchRequest:request error:&error] lastObject];
    OptionsViewController *optionsVC = [[OptionsViewController alloc] initWithNibName:@"OptionsViewController" bundle:nil];
    optionsVC.jlptSchedule = jlptSchedule;
    optionsVC.managedObjectContext = managedObjectContext;
    [self.navigationController pushViewController:optionsVC animated:YES];
    [optionsVC release];
    [request release];
}

- (void)toAbout {
    AboutViewController *aboutVC = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [self.navigationController pushViewController:aboutVC animated:YES];
    [aboutVC release];
}

- (void)dealloc
{
    [jlptSchedule release];
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
