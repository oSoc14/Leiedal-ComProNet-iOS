//
//  LoginViewController.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 08/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginScrollV = _loginScrollV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testInternetConnection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    self.loginScrollV = [[LoginScrollView alloc] initWithFrame:frame];
    self.loginScrollV.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, self.loginScrollV.background.frame.size.height);
    self.loginScrollV.delegate = self.loginScrollV;
    self.loginScrollV.scrollEnabled = YES;
    self.loginScrollV.delaysContentTouches = YES;
    self.loginScrollV.canCancelContentTouches = NO;
    [self.loginScrollV setShowsHorizontalScrollIndicator:NO];
    [self.loginScrollV setShowsVerticalScrollIndicator:NO];
    [self setView:self.loginScrollV];
}

-(void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    //__weak typeof(self) weakSelf = self;
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"INTERNET_AVAILABLE" object:nil];
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NO_INTERNET_AVAILABLE" object:nil];
        });
    };
    
    [internetReachableFoo startNotifier];
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
