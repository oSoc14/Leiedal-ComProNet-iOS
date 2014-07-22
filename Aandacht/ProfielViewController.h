//
//  ProfielViewController.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfielView.h"

@interface ProfielViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(strong, nonatomic) ProfielView *profielV;

@end
