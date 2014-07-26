//
//  LoginScrollView.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "LoginScrollView.h"
#import "Constants.h"

@implementation LoginScrollView

@synthesize imageDir = _imageDir;
@synthesize alert = _alert;
@synthesize background = _background;
@synthesize lightStar = _lightStar;

@synthesize arrAnimatedObjects = _arrAnimatedObjects;
@synthesize logoImageV = _logoImageV;
@synthesize lblTitel = _lblTitel;
@synthesize txtUserName = _txtUserName;
@synthesize txtPassWord = _txtPassWord;
@synthesize btnLogin = _btnLogin;
@synthesize lblFeedback = _lblFeedback;

@synthesize ownContentSize = _ownContentSize;
@synthesize allowScrollControl = _allowScrollControl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.allowScrollControl = false;
        self.imageDir = [NSString stringWithFormat:@"%@/%s", imageDir, "views/login"];
        self.backgroundColor = [UIColor colorWithRed:(26/255.0) green:(62/255.0) blue:(176/255.0) alpha:1];
        self.arrAnimatedObjects = [[NSMutableArray alloc] init];
        
        //INTERNET CONNECTION FAILURE ALERT
        self.alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert_no_connection_title", @"") message:NSLocalizedString(@"alert_no_connection_description", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"alert_no_connection_option", @"") otherButtonTitles:nil];
        
        //BACKGROUND IMAGE
        self.background = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"background" ofType:@"png" inDirectory:self.imageDir] andFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 700)];
        [self addSubview:self.background];
        
        //LIGHT STAR
        self.lightStar = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"light_star" ofType:@"png" inDirectory:self.imageDir] andFrame:CGRectMake(0, -95, [[UIScreen mainScreen] bounds].size.width, 506)];
        [self.arrAnimatedObjects addObject:self.lightStar];
        [self addSubview:self.lightStar];
        
        CABasicAnimation* rotate =  [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
        rotate.removedOnCompletion = FALSE;
        rotate.fillMode = kCAFillModeForwards;
        
        //Do a series of 5 quarter turns for a total of a 1.25 turns
        //(2PI is a full turn, so pi/2 is a quarter turn)
        [rotate setToValue: [NSNumber numberWithFloat: M_PI / 2]];
        rotate.repeatCount = 11;
        
        rotate.duration = 25/2;
        rotate.beginTime = 0;
        rotate.cumulative = TRUE;
        rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        [self.lightStar.layer addAnimation: rotate forKey: @"rotateAnimation"];
        
        //LOGO
        self.logoImageV = [Constants createImageView:[[NSBundle mainBundle] pathForResource:@"logo_big" ofType:@"png" inDirectory:self.imageDir] andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 76)/2, 130 - animationHeightDiff, 76, 99)];
        [self addSubview:self.logoImageV];
        
        //TITLE LABEL
        self.lblTitel = [Constants createLabel:[NSLocalizedString(@"app_title", @"") uppercaseString] andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - 130.5)/2, 228, 132, 20) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:[UIColor whiteColor] andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:24]];
        [self.arrAnimatedObjects addObject:self.lblTitel];
        [self addSubview:self.lblTitel];
        
        //TEXTFIELD USERNAME
        self.txtUserName = [Constants createTextField:NSLocalizedString(@"login_username_placeholder", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 339, defaultContentWidth, loginInputHeight) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:@"input_username_bg" ofType:@"png" inDirectory:self.imageDir] andTextAlignment:NSTextAlignmentCenter andTextColor:inputTextColor andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17]
            andPlaceHolderColor:inputPlaceHolderColor];
        self.txtUserName.delegate = self;
        self.txtUserName.autocorrectionType = UITextAutocorrectionTypeNo;
        [self.arrAnimatedObjects addObject:self.txtUserName];
        [self addSubview:self.txtUserName];
        
        //TEXTFIELD PASSWORD
        self.txtPassWord = [Constants createTextField:NSLocalizedString(@"login_password_placeholder", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 380, defaultContentWidth, loginInputHeight) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:@"input_password_bg" ofType:@"png" inDirectory:self.imageDir] andTextAlignment:NSTextAlignmentCenter andTextColor:inputTextColor andFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17] andPlaceHolderColor:inputPlaceHolderColor];
        self.txtPassWord.delegate = self;
        self.txtPassWord.secureTextEntry = YES;
        [self.arrAnimatedObjects addObject:self.txtPassWord];
        [self addSubview:self.txtPassWord];
        
        //LOGIN BUTTON
        self.btnLogin = [Constants createCustomButton:[NSLocalizedString(@"login_submit_button", @"") uppercaseString] andTextColor:[UIColor colorWithRed:(24/255.0) green:(76/255.0) blue:(122/255.0) alpha:1] andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 435, defaultContentWidth, loginInputHeight) andBackgroundImagePath:[[NSBundle mainBundle] pathForResource:@"input_login_bg" ofType:@"png" inDirectory:self.imageDir] andBackgroundHoverImagePath:[[NSBundle mainBundle] pathForResource:@"input_login_bg_h" ofType:@"png" inDirectory:self.imageDir] andFont:[UIFont fontWithName:@"BrandonGrotesque-Black" size:21]];
        [self.arrAnimatedObjects addObject:self.btnLogin];
        [self addSubview:self.btnLogin];
        
        //set initial content size
        self.contentSize = CGSizeMake(self.ownContentSize.width, [[UIScreen mainScreen] bounds].size.height);
        
        //TEMPORARY - FILL FORM
        [self.txtUserName setText:@"Bastiaan"];
        [self.txtPassWord setText:@"test12"];
        
        [self animateObjects];
    }
    return self;
}

-(void)animateObjects{
    //initial fadein
    float i = 0;
    for (UIView *object in self.arrAnimatedObjects) {
        [object setFrame:CGRectMake(object.frame.origin.x, object.frame.origin.y - animationHeightDiff, object.frame.size.width, object.frame.size.height)];
        [object setAlpha:0];
        float delay = i*0.1;
        if(object == self.txtPassWord || object == self.btnLogin){
            delay = (i-1)*0.1;
        }
        [UIView animateWithDuration:0.7 delay:delay options:UIViewAnimationOptionLayoutSubviews animations:^{
            object.alpha = 1;
            if(object == self.lightStar){
                object.alpha = 0.7;
            }
            object.frame = CGRectMake(object.frame.origin.x, object.frame.origin.y + animationHeightDiff, object.frame.size.width, object.frame.size.height);
        } completion:^(BOOL finished){
            if(object == self.btnLogin){
                [self.btnLogin addTarget:self action:@selector(loginUser:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
        i++;
    }
}

-(void)loginUser:(id)sender{
    [self.lblFeedback removeFromSuperview];
    
    //set default colors
    self.txtUserName.textColor = inputTextColor;
    self.txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"login_username_placeholder", @"") attributes:@{NSForegroundColorAttributeName: inputPlaceHolderColor}];
    self.txtPassWord.textColor = inputTextColor;
    self.txtPassWord.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"login_password_placeholder", @"") attributes:@{NSForegroundColorAttributeName: inputPlaceHolderColor}];
    [self.lblFeedback removeFromSuperview];
    
    //check input
    if([[self.txtUserName text] isEqual:userName] && [[Constants sha1:[self.txtPassWord text]] isEqual:userPass]){
        [self.txtUserName resignFirstResponder];
        [self.txtPassWord resignFirstResponder];
        [[NSUserDefaults standardUserDefaults] setObject:[self.txtUserName text]  forKey:@"username"];
        [self.txtUserName setText:@""];
        [self.txtPassWord setText:@""];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"USER_LOGGED_IN" object:nil];
    }else{
        if([[self.txtUserName text] length] == 0 || [[self.txtPassWord text] length] == 0){
            self.lblFeedback = [Constants createLabel:NSLocalizedString(@"login_feedback_empty", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 305, defaultContentWidth, 20) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:inputErrorTextColor andFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16]];
            if([[self.txtUserName text] length] == 0){
                self.txtUserName.textColor = inputErrorTextColor;
                self.txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"login_username_placeholder", @"") attributes:@{NSForegroundColorAttributeName: inputErrorTextColor}];
            }
            if([[self.txtPassWord text] length] == 0){
                self.txtPassWord.textColor = inputErrorTextColor;
                self.txtPassWord.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"login_password_placeholder", @"") attributes:@{NSForegroundColorAttributeName: inputErrorTextColor}];
            }
        }else{
            self.lblFeedback = [Constants createLabel:NSLocalizedString(@"login_feedback_wrong", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 305, defaultContentWidth, 20) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:inputErrorTextColor andFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16]];
            self.txtUserName.textColor = inputErrorTextColor;
            self.txtPassWord.textColor = inputErrorTextColor;
        }
        [self.lblFeedback setAlpha:0];
        [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.lblFeedback.alpha = 1;
        } completion:^(BOOL finished){}];
        [self addSubview:self.lblFeedback];
    }
}

//TEXTFIELD CONTROL
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.txtUserName resignFirstResponder];
        [self.txtPassWord resignFirstResponder];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.allowScrollControl = YES;
    self.ownContentSize = self.contentSize;
    self.contentSize = CGSizeMake(self.ownContentSize.width, 5000);
    
    UIScrollView* v = (UIScrollView*) self ;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:v];
    rc.origin.x = 0 ;
    if(textField == self.txtUserName){
        rc.origin.y -= 100 ;
    }else if(textField == self.txtPassWord){
        rc.origin.y -= 180 ;
    }
    rc.size.height = 1000;
    [self scrollRectToVisible:rc animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.allowScrollControl = NO;
    [UIView animateWithDuration:.3 animations:^{
        if(self.background.frame.size.height > [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, 100);
        }
    }completion:^(BOOL finished){
        self.contentSize = self.ownContentSize;
    }];
}

//SCROLL CONTROL
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.contentOffset.y < 0){
        self.contentOffset = CGPointMake(0, 0);
    }
    if(self.background.frame.size.height > [[UIScreen mainScreen] bounds].size.height && self.allowScrollControl){
        if(self.contentOffset.y > self.background.frame.size.height - [[UIScreen mainScreen] bounds].size.height){
            self.contentOffset = CGPointMake(0, self.background.frame.size.height - [[UIScreen mainScreen] bounds].size.height);
        }
    } else {
        self.contentOffset = CGPointMake(0, 0);
    }
}

//DISABLE WHEN OFFLINE, ENABLE WHEN CONNECTED
-(void)disableForm{
    [self.alert show];
    [self.txtUserName setEnabled:NO];
    [self.txtPassWord setEnabled:NO];
    [self.lblFeedback removeFromSuperview];
    self.lblFeedback = [Constants createLabel:NSLocalizedString(@"login_feedback_no_connection", @"") andFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width - defaultContentWidth)/2, 305, defaultContentWidth, 20) andBackgroundColor:[UIColor clearColor] andAlignment:NSTextAlignmentCenter andTextColor:inputErrorTextColor andFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16]];
    self.lblFeedback.alpha = 0;
    self.lblFeedback.numberOfLines = 0;
    self.lblFeedback.frame = CGRectMake(self.lblFeedback.frame.origin.x, self.lblFeedback.frame.origin.y - 25, self.lblFeedback.frame.size.width, self.lblFeedback.frame.size.height + 25);
    [self addSubview:self.lblFeedback];
    [UIView animateWithDuration:0.3 animations:^{
        self.txtUserName.alpha = 0.4;
        self.txtPassWord.alpha = 0.4;
        self.lblFeedback.alpha = 1;
    } completion:nil];
    [self.btnLogin setEnabled:NO];
}

-(void)enableForm{
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
    [self.txtUserName setEnabled:YES];
    [self.txtPassWord setEnabled:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.txtUserName.alpha = 1;
        self.txtPassWord.alpha = 1;
        self.lblFeedback.alpha = 0;
    } completion:^(BOOL finished){
        [self.lblFeedback removeFromSuperview];
    }];
    [self.btnLogin setEnabled:YES];
}

@end
