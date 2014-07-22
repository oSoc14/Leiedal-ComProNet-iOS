//
//  Constants.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Incident.h"

@interface Constants : NSObject

//CONSTANTS
extern NSString * const userName;
extern NSString * const userPass;
extern bool isUserActive;
extern NSArray *arrUserMetaData;
extern NSMutableArray *arrIncidents;
extern NSMutableArray *arrSelectedIncidents;
extern Incident * currentSelectedIncident;

extern NSString * const imageDir;
extern NSString * const navDir;
extern NSString * const timeZone;

extern NSString * const pathAcceptedActive;
extern NSString * const pathAcceptedInactive;
extern NSString * const pathDeniedActive;
extern NSString * const pathDeniedInactive;

extern UIColor *defaultGrayBackgroundColor;
extern UIColor *headerBackgroundColor;
extern UIColor *defaultDarkGrayBorder;
extern UIColor *defaultLightGrayBorder;
extern UIColor *inputTextColor;
extern UIColor *inputPlaceHolderColor;
extern UIColor *inputErrorTextColor;
extern UIColor *incidentListItemTextColor;

extern float const bottomBarHeight;
extern float const defaultContentWidth;
extern float const animationHeightDiff;
extern float const loginInputHeight;
extern float const incidentListItemViewHeight;
extern float const incidentListItemStatusIconLeft;
extern float const incidentListItemTextLeft;
extern float const incidentListItemTextWidth;
extern float const toggleButtonDimension;

extern float const settingsItemHeight;

extern NSDateFormatter *dateFormat;
extern int const second;
extern int const minute;
extern int const hour;
extern int const day;
extern int const week;

//METHODS
+(void)setConstants;
+(UIImageView*)createImageView:(NSString*)imagePath andFrame:(CGRect)frame;
+(UILabel*)createLabel:(NSString *)labelTitle andFrame:(CGRect)frame andBackgroundColor:(UIColor*)backgroundColor andAlignment:(NSTextAlignment)alignment andTextColor:(UIColor*)textColor andFont:(UIFont*)font;
+(UITextField*)createTextField:(NSString *)textFieldTitle andFrame:(CGRect)frame andBackgroundImagePath:(NSString*)path andTextAlignment:(NSTextAlignment)alignment andTextColor:(UIColor*)textColor andFont:(UIFont*)font andPlaceHolderColor:(UIColor*)placeHolderColor;
+(UIButton*)createCustomButton:(NSString *)buttonText andTextColor:(UIColor*)textColor andFrame:(CGRect)frame andBackgroundImagePath:(NSString*)path andBackgroundHoverImagePath:(NSString*)pathHover andFont:(UIFont*)font;
+ (NSString *)sha1:(NSString *)encryptedString;
+ (NSDate *)getCurrentDate;
+(void)loadIncidentsData;
+(void)setSelectedIncidentsWithMultipleStatuses:(NSArray*)arrStatuses;
+(NSMutableArray*)selectIncidentsWithMultipleStatuses:(NSArray*)arrStatus;

@end
