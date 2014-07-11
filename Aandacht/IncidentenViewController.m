//
//  IncidentenViewController.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "IncidentenViewController.h"
#import "Constants.h"

@interface IncidentenViewController ()

@end

@implementation IncidentenViewController

@synthesize navCont = _navCont;
@synthesize incidentenV = _incidentenV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"nav_incidenten", @"");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"nav_incidenten" ofType:@"png" inDirectory:navDir];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:image tag:0];
        
        /*self.navCont = [[UINavigationController alloc] init];
        [self.navCont pushViewController:self.loginVC animated:YES];
        [self.navCont setNavigationBarHidden:YES animated:NO];*/
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ingredientSelected:) name:@"INGREDIENT_SELECTED" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    self.incidentenV = [[IncidentenView alloc] initWithFrame:frame];
    [self setView:self.incidentenV];
    //[self loadIncidents];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
