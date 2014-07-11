//
//  HeaderView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

@property(strong, nonatomic) NSString *imagesDir;
@property(strong, nonatomic) UIImageView *imgLogo;
@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UIButton *btnLogout;

@end
