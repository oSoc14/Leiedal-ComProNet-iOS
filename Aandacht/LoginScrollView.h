//
//  LoginScrollView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>

@property(strong, nonatomic) NSString *imageDir;
@property(strong, nonatomic) UIImageView *background;
@property(strong, nonatomic) UIImageView *lightStar;

@property(strong, nonatomic) NSMutableArray *arrAnimatedObjects;
@property(strong, nonatomic) UIImageView *logoImageV;
@property(strong, nonatomic) UILabel *lblTitel;
@property(strong, nonatomic) UITextField *txtUserName;
@property(strong, nonatomic) UITextField *txtPassWord;
@property(strong, nonatomic) UIButton *btnLogin;
@property(strong, nonatomic) UILabel *lblFeedback;

@property(nonatomic) CGSize ownContentSize;
@property(nonatomic) BOOL allowScrollControl;

-(void)animateObjects;

@end
