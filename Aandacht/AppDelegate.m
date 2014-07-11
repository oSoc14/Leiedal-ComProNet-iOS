//
//  AppDelegate.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 08/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "AppDelegate.h"
#import "Incident.h"
#import "Constants.h"

@implementation AppDelegate

@synthesize navCont = _navCont;
@synthesize incidentenNavCont = _incidentenNavCont;
@synthesize tabbarController = _tabbarController;

@synthesize loginVC = _loginVC;
@synthesize incidentenVC = _incidentenVC;
@synthesize kaartVC = _kaartVC;
@synthesize profielVC = _profielVC;
@synthesize instellingenVC = _instellingenVC;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //set constant vars
    [Constants setConstants];
    
    //event listeners
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showIncidents:) name:@"USER_LOGGED_IN" object:nil];

    //create initial view
    self.loginVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    self.navCont = [[UINavigationController alloc] init];
    [self.navCont pushViewController:self.loginVC animated:YES];
    [self.navCont setNavigationBarHidden:YES animated:NO];
    [self.window setRootViewController:self.navCont];
    
    //TEMPORARY SET TO WORK VIEW
    [self showIncidents:NULL];
    
    //set background color status bar
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        self.window.clipsToBounds = YES;
        [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
        
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
        {
            self.window.frame =  CGRectMake(20, 0,self.window.frame.size.width-20,self.window.frame.size.height);
            self.window.bounds = CGRectMake(20, 0, self.window.frame.size.width, self.window.frame.size.height);
        } else
        {
            self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
            self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
        }
    }
    
    //[self readDataFromFile];
    
    self.window.backgroundColor = [UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:247 alpha:1];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)readDataFromFile
{
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"incidenten" ofType:@"json"];
    
    NSError * error;
    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    
    if(error)
    {
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    
    
    NSArray *arrIncidents = (NSArray *)[NSJSONSerialization
                                JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                options:0 error:NULL];
    NSLog(@"%@", arrIncidents);

}

//NAVIGATION
-(void)showIncidents:(id)sender{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"USER_LOGGED_IN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogin:) name:@"USER_LOGOUT" object:nil];
    
    self.incidentenVC = [[IncidentenViewController alloc] initWithNibName:nil bundle:nil];
    self.kaartVC = [[KaartViewController alloc] initWithNibName:nil bundle:nil];
    self.profielVC = [[ProfielViewController alloc] initWithNibName:nil bundle:nil];
    self.instellingenVC = [[InstellingenViewController alloc] initWithNibName:nil bundle:nil];
    
    self.incidentenNavCont = [[UINavigationController alloc] init];
    [self.incidentenNavCont pushViewController:self.incidentenVC animated:YES];
    [self.incidentenNavCont setNavigationBarHidden:YES animated:NO];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:self.incidentenNavCont, self.kaartVC, self.profielVC, self.instellingenVC, nil];
    
    self.tabbarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    self.tabbarController.tabBar.translucent = NO;
    if ([self.tabbarController.tabBar respondsToSelector:@selector(setTintColor:)]) {
        [self.tabbarController.tabBar setTintColor:[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1]];
    }
    [self.tabbarController setViewControllers:viewControllers animated:YES];
    
    [self.navCont pushViewController:self.tabbarController animated:YES];
}

-(void)showLogin:(id)sender{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showIncidents:) name:@"USER_LOGGED_IN" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"USER_LOGOUT" object:nil];
    
    NSLog(@"showLogin");
    [self.navCont popViewControllerAnimated:YES];
}

//APPLICATION CALLBACK METHODS
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Aandacht" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Aandacht.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end