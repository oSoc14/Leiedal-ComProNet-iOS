//
//  LoginViewController.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 08/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginScrollView.h"
#import "Reachability.h"

@interface LoginViewController : UIViewController {
    Reachability *internetReachableFoo;
}


@property (strong, nonatomic) LoginScrollView *loginScrollV;

@end
