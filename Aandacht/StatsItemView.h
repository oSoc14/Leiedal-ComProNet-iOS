//
//  StatsItemView.h
//  Aandacht
//
//  Created by Bastiaan Andriessen on 21/07/14.
//  Copyright (c) 2014 Bastiaan Andriessen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatsItemView : UIView

@property(strong, nonatomic) NSString *imageDir;
@property(strong, nonatomic) NSDictionary *dictionary;
@property(strong, nonatomic) UILabel *lblTitle;
@property(strong, nonatomic) UIImageView *imageV;
@property(strong, nonatomic) UILabel *lblTime;
@property(strong, nonatomic) UILabel *lblTimeUnit;

- (id)initWithFrame:(CGRect)frame andWithData:(NSDictionary*)dictionary;

@end
