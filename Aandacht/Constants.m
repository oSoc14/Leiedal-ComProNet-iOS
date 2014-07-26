//
//  Constants.m
//  Aandacht
//
//  Created by Bastiaan Andriessen on 09/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import "Constants.h"
#import <CommonCrypto/CommonDigest.h>
#import "Incident.h"

@implementation Constants
NSDictionary * userPolice;
NSDictionary * userCurrent;

NSString * const userName = @"Bastiaan";
//decoded password = test12
NSString * const userPass = @"4ff1a33e188b7b86123d6e3be2722a23514a83b4";
bool isUserActive = true;
NSArray *arrUserMetaData;
NSMutableArray *arrPushIncidents;
NSMutableArray *arrIncidents;
NSMutableArray *arrSelectedIncidents;
Incident * currentSelectedIncident;

NSString * const imageDir = @"images/";
NSString * const navDir = @"images/nav";
NSString * const timeZone = @"+0001";

NSString * const pathAcceptedActive = @"button_confirm_active";
NSString * const pathAcceptedInactive = @"button_confirm_inactive";
NSString * const pathDeniedActive = @"button_deny_active";
NSString * const pathDeniedInactive = @"button_deny_inactive";

UIColor * defaultGrayBackgroundColor;
UIColor * headerBackgroundColor;
UIColor * defaultDarkGrayBorder;
UIColor * defaultLightGrayBorder;
UIColor * inputTextColor;
UIColor * inputPlaceHolderColor;
UIColor * inputErrorTextColor;
UIColor * incidentListItemTextColor;

float const bottomBarHeight = 50;
float const defaultContentWidth = 288;
float const animationHeightDiff = 20;
float const loginInputHeight = 40;
float const incidentListItemViewHeight = 75;
float const incidentListItemStatusIconLeft = 23;
float const incidentListItemTextLeft = 44;
float const incidentListItemTextWidth = 190;
float const settingsItemHeight = 42;
float const toggleButtonDimension = 22;
float const userIconDimension = 42;
float const messageTextTopOffset = 7;

NSDateFormatter *dateFormat;
int const second = 1;
int const minute = 60;
int const hour = 60*60;
int const day = 60*60*24;
int const week = 60*60*24*7;

+(void)setConstants{
    Incident *incident1 = [[Incident alloc] initWithId:5 andAddress:@"Wijngaardstraat 262" andCity:@"8500 Kortrijk" andDescription:@"In de Bart Smit winkel in de K is er een discussie uit de hand gelopen nadat een klant beweerde op meer korting recht te hebben." andLatitude:50.826202 andLongitude:3.269921 andTimeStamp:0 andDurationTimeStamp:0 andStatus:@"pending"];
    
    Incident *incident2 = [[Incident alloc] initWithId:6 andAddress:@"Vlasmarkt 1" andCity:@"8500 Kortrijk" andDescription:@"In een van de cafés op de vlasmarkt, genaamd 'Gainsbar', wil een klant het café niet verlaten ondanks het café wil sluiten. De persoon in kwestie is onder invloed." andLatitude:50.825659 andLongitude:3.267618 andTimeStamp:0 andDurationTimeStamp:0 andStatus:@"pending"];
    
    Incident *incident3 = [[Incident alloc] initWithId:7 andAddress:@"Vlamingenstraat 32" andCity:@"8500 Kortrijk" andDescription:@"Een adolescent heeft z'n raam open met veel te luide muziek op." andLatitude:50.825352 andLongitude:3.270232 andTimeStamp:0 andDurationTimeStamp:0 andStatus:@"pending"];
    
    arrPushIncidents = [[NSMutableArray alloc] initWithObjects:incident1, incident2, incident3, nil];
    
    arrUserMetaData = [[NSArray alloc] initWithObjects:
                       [[NSMutableDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"profiel_stats1", @"8607600", @"icon_total_time_active", NSLocalizedString(@"date_hours", @""), nil] forKeys:[[NSArray alloc] initWithObjects:@"name", @"time", @"src", @"unit", nil]],
                       [[NSMutableDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:@"profiel_stats2", @"41", @"icon_average_respons_time", NSLocalizedString(@"date_seconds", @""), nil] forKeys:[[NSArray alloc] initWithObjects:@"name", @"time", @"src", @"unit", nil]], nil];
    
    
    defaultDarkGrayBorder = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(231/255.0) alpha:1];
    headerBackgroundColor = [UIColor colorWithRed:(246/255.0) green:(246/255.0) blue:(246/255.0) alpha:1];
    defaultLightGrayBorder = [UIColor colorWithRed:(178/255.0) green:(178/255.0) blue:(178/255.0) alpha:1];
    defaultGrayBackgroundColor = [UIColor colorWithRed:(239/255.0) green:(239/255.0) blue:(244/255.0) alpha:1];
    inputTextColor = [UIColor colorWithRed:(24/255.0) green:(76/255.0) blue:(122/255.0) alpha:1.00f];
    inputPlaceHolderColor = [UIColor colorWithRed:(177/255.0) green:(177/255.0) blue:(177/255.0) alpha:(177/255.0)];
    inputErrorTextColor = [UIColor colorWithRed:(253/255.0) green:(143/255.0) blue:(143/255.0) alpha:1];
    incidentListItemTextColor = [UIColor colorWithRed:(16/255.0) green:(135/255.0) blue:(218/255.0) alpha:1];
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [self loadIncidentsData];
}

+(UIImageView*)createImageView:(NSString*)imagePath andFrame:(CGRect)frame
{
    UIImage *imageBg = [[UIImage alloc] initWithContentsOfFile:imagePath];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:imageBg];
    [imageV setFrame:frame];
    return imageV;
}

+(UILabel*)createLabel:(NSString *)labelTitle andFrame:(CGRect)frame andBackgroundColor:(UIColor*)backgroundColor andAlignment:(NSTextAlignment)alignment andTextColor:(UIColor*)textColor andFont:(UIFont*)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = labelTitle;
    label.backgroundColor = backgroundColor;
    label.textAlignment = alignment;
    label.textColor = textColor;
    label.font = font;
    return label;
}

+(UITextField*)createTextField:(NSString *)textFieldPlaceHolder andFrame:(CGRect)frame andBackgroundImagePath:(NSString*)path andTextAlignment:(NSTextAlignment)alignment andTextColor:(UIColor*)textColor andFont:(UIFont*)font andPlaceHolderColor:(UIColor*)placeHolderColor{
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:frame];
    if(![path isEqual: @""]){
        UIImage *userNameBg = [[UIImage alloc] initWithContentsOfFile:path];
        [textfield setBackground:userNameBg];
    }
    textfield.textAlignment = alignment;
    textfield.textColor = textColor;
    textfield.font = font;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UIColor *placeHolderTextColor = placeHolderColor;
    if ([textfield respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = placeHolderTextColor;
        textfield.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(textFieldPlaceHolder, @"") attributes:@{NSForegroundColorAttributeName: color}];
    }else{
        [textfield setPlaceholder:NSLocalizedString(textFieldPlaceHolder, @"")];
    }
    
    return textfield;
}

+(UIButton*)createCustomButton:(NSString *)buttonText andTextColor:(UIColor*)textColor andFrame:(CGRect)frame andBackgroundImagePath:(NSString*)path andBackgroundHoverImagePath:(NSString*)pathHover andFont:(UIFont*)font
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    if(![path isEqual:@""]){
        UIImage *buttonBg = [[UIImage alloc] initWithContentsOfFile:path];
        [button setBackgroundImage:buttonBg forState:UIControlStateNormal];
    }
    
    if(![pathHover isEqual:@""]){
        UIImage *buttonBgH = [[UIImage alloc] initWithContentsOfFile:pathHover];
        [button setBackgroundImage:buttonBgH forState:UIControlStateHighlighted];
    }
    
    [button setTitle:buttonText forState:UIControlStateNormal];
    [[button titleLabel] setFont:font];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    return button;
}

+ (NSString *)sha1:(NSString *)encryptedString
{
    NSData *data = [encryptedString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (NSDate *)getCurrentDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSHourCalendarUnit  | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    NSString *timeStampNow = [NSString stringWithFormat:@"%li-%li-%li %li:%li:%li", (long)[dateComponents year], (long)[dateComponents month], (long)[dateComponents day], (long)[dateComponents hour], (long)[dateComponents minute], (long)[dateComponents second]];
    NSDate *date = [dateFormat dateFromString:timeStampNow];
    return date;
}

//DATA
+(void)loadIncidentsData{
    //create current date
    NSString *now = [dateFormat stringFromDate:[Constants getCurrentDate]];
    
    //incident1
    NSDate *dateTimeStamp1 = [dateFormat dateFromString:now];
    dateTimeStamp1 = [dateTimeStamp1 dateByAddingTimeInterval:-minute];
    NSString *timeStamp1 = [dateFormat stringFromDate:dateTimeStamp1];
    
    NSDate *dateDurationTimeStamp1 = [dateFormat dateFromString:now];
    dateDurationTimeStamp1 = [dateDurationTimeStamp1 dateByAddingTimeInterval:hour-minute];
    NSString *durationTimeStamp1 = [dateFormat stringFromDate:dateDurationTimeStamp1];
    
    Incident *incident1 = [[Incident alloc] initWithId:0 andAddress:@"Nieuwstraat 25" andCity:@"8500 Kortrijk" andDescription:@"Er staan enkele personen op het dak van het wijkcentrum. Verdachte activiteiten gespot!" andLatitude:50.825114 andLongitude:3.269480 andTimeStamp:timeStamp1 andDurationTimeStamp:durationTimeStamp1 andStatus:@"pending"];
    
    //incident2
    NSDate *dateTimeStamp2 = [dateFormat dateFromString:now];
    dateTimeStamp2 = [dateTimeStamp2 dateByAddingTimeInterval:-(5*minute)];
    NSString *timeStamp2 = [dateFormat stringFromDate:dateTimeStamp2];
    
    NSDate *dateDurationTimeStamp2 = [dateFormat dateFromString:now];
    dateDurationTimeStamp2 = [dateDurationTimeStamp2 dateByAddingTimeInterval:(4*hour)-(5*minute)];
    NSString *durationTimeStamp2 = [dateFormat stringFromDate:dateDurationTimeStamp2];
    
    Incident *incident2 = [[Incident alloc] initWithId:1 andAddress:@"Doorniksestraat 129" andCity:@"8500 Kortrijk" andDescription:@"Kind verloren ter hoogte van de bloemenwinkel. Het kind heet Waldo Verstraete en draagt een blauwe jeansbroek met een geruite trui in wit en rood. Verder draagt hij ook een wit en rood streepte muts. Mogelijks is hij richting het centrum gelopen." andLatitude:50.824630 andLongitude:3.268462 andTimeStamp:timeStamp2 andDurationTimeStamp:durationTimeStamp2 andStatus:@"active"];
    
    //incident3
    NSDate *dateTimeStamp3 = [dateFormat dateFromString:now];
    dateTimeStamp3 = [dateTimeStamp3 dateByAddingTimeInterval:-(7*minute)];
    NSString *timeStamp3 = [dateFormat stringFromDate:dateTimeStamp3];
    
    NSDate *dateDurationTimeStamp3 = [dateFormat dateFromString:now];
    dateDurationTimeStamp3 = [dateDurationTimeStamp3 dateByAddingTimeInterval:(5*hour)-(7*minute)];
    NSString *durationTimeStamp3 = [dateFormat stringFromDate:dateDurationTimeStamp3];
    
    Incident *incident3 = [[Incident alloc] initWithId:2 andAddress:@"Sint-Jorisstraat 50" andCity:@"8500 Kortrijk" andDescription:@"3 auto’s betrokken in een auto ongeval. Geen zwaargewonden, wel paniek en veel blikschade" andLatitude:50.824953 andLongitude:3.266721 andTimeStamp:timeStamp3 andDurationTimeStamp:durationTimeStamp3 andStatus:@"denied"];
    
    //incident4
    NSDate *dateTimeStamp4 = [dateFormat dateFromString:now];
    dateTimeStamp4 = [dateTimeStamp4 dateByAddingTimeInterval:-day];
    NSString *timeStamp4 = [dateFormat stringFromDate:dateTimeStamp4];
    
    NSDate *dateDurationTimeStamp4 = [dateFormat dateFromString:now];
    dateDurationTimeStamp4 = [dateDurationTimeStamp4 dateByAddingTimeInterval:hour-day];
    NSString *durationTimeStamp4 = [dateFormat stringFromDate:dateDurationTimeStamp4];
    
    Incident *incident4 = [[Incident alloc] initWithId:3 andAddress:@"Zwevegemsestraat 24" andCity:@"8500 Kortrijk" andDescription:@"Fietsen worden gestolen aan de fietsensrekken aan de ingang van de ondergrondse parking van de K." andLatitude:3.272042 andLongitude:3.272042 andTimeStamp:timeStamp4 andDurationTimeStamp:durationTimeStamp4 andStatus:@"finished"];
    
    //incident5
    NSDate *dateTimeStamp5 = [dateFormat dateFromString:now];
    dateTimeStamp5 = [dateTimeStamp5 dateByAddingTimeInterval:-day*100];
    NSString *timeStamp5 = [dateFormat stringFromDate:dateTimeStamp5];
    
    NSDate *dateDurationTimeStamp5 = [dateFormat dateFromString:now];
    dateDurationTimeStamp5 = [dateDurationTimeStamp5 dateByAddingTimeInterval:(hour*0.5)-day];
    NSString *durationTimeStamp5 = [dateFormat stringFromDate:dateDurationTimeStamp5];
    
    Incident *incident5 = [[Incident alloc] initWithId:4 andAddress:@"Filip van de Elzaslaan 39" andCity:@"8500 Kortrijk" andDescription:@"Diefstal van een handtas ter hoogte van het JOC." andLatitude:50.819478 andLongitude:3.257726 andTimeStamp:timeStamp5 andDurationTimeStamp:durationTimeStamp5 andStatus:@"finished"];
    
    arrIncidents = [[NSMutableArray alloc] initWithObjects:incident1, incident2, incident3, incident4, incident5, nil];
}

+(void)setSelectedIncidentsWithMultipleStatuses:(NSArray*)arrStatuses{
    arrSelectedIncidents = [self selectIncidentsWithMultipleStatuses:arrStatuses];
}

+(NSMutableArray*)selectIncidentsWithMultipleStatuses:(NSArray*)arrStatuses{
    NSMutableArray *arrResultIncidents = [[NSMutableArray alloc] init];
    for(int i = 0; i<[arrStatuses count]; i++){
        for(int j=0; j<[arrIncidents count]; j++){
            Incident *currentIncident = ((Incident*)[arrIncidents objectAtIndex:j]);
            if([currentIncident.status isEqualToString:[arrStatuses objectAtIndex:i]]){
                [arrResultIncidents addObject:currentIncident];
            }
        }
    }
    return arrResultIncidents;
}

@end
