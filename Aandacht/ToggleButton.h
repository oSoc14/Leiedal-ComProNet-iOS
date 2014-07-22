//
//  ToggleButton.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 18/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToggleButton : UIButton

@property(strong, nonatomic) NSString *imageDir;
@property(strong, nonatomic) NSString *pathActive;
@property(strong, nonatomic) NSString *pathInactive;
@property(nonatomic) bool isActive;
//@property(strong, nonatomic) UIButton *button;

- (id)initWithFrame:(CGRect)frame andToggleKind:(NSString*)kind;
- (void)setInactive;
- (void)setActive;

@end
