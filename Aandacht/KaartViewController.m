//
//  KaartViewController.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "KaartViewController.h"
#import "Constants.h"

@interface KaartViewController ()

@end

@implementation KaartViewController

@synthesize kaartV = _kaartV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.title = NSLocalizedString(@"nav_kaart", @"");
        NSString *path = [[NSBundle mainBundle] pathForResource:@"nav_kaart" ofType:@"png" inDirectory:navDir];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:image tag:1];
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
    
    self.kaartV = [[KaartView alloc] initWithFrame:frame];
    [self setView:self.kaartV];
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
