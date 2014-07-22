//
//  AppDelegate.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 08/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "IncidentenViewController.h"
#import "KaartViewController.h"
#import "ProfielViewController.h"
#import "InstellingenViewController.h"
#import "IncidentDetailViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) UINavigationController *navCont;
@property (strong, nonatomic) UITabBarController *tabbarController;
@property(strong, nonatomic) UINavigationController *incidentenNavCont;

@property(strong, nonatomic) LoginViewController *loginVC;
@property(strong, nonatomic) IncidentenViewController *incidentenVC;
@property(strong, nonatomic) KaartViewController *kaartVC;
@property(strong, nonatomic) ProfielViewController *profielVC;
@property(strong, nonatomic) InstellingenViewController *instellingenVC;
@property(strong, nonatomic) IncidentDetailViewController *incidentDetailVC;

@property(nonatomic) bool subscribedToNotifications;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
