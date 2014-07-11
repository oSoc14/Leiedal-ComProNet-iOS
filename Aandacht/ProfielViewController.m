//
//  ProfielViewController.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "ProfielViewController.h"
#import "Constants.h"

@interface ProfielViewController ()

@end

@implementation ProfielViewController

@synthesize profielV = _profielV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"nav_profiel", @"");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"nav_profiel" ofType:@"png" inDirectory:navDir];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:image tag:2];
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
    
    self.profielV = [[ProfielView alloc] initWithFrame:frame];
    [self setView:self.profielV];
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
