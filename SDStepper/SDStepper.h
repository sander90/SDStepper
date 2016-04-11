//
//  SDStepper.h
//  SDStepper
//
//  Created by shansander on 16/4/10.
//  Copyright © 2016年 shansander. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    STEPPER_LEFT_SIDE,
    STEPPER_RIGHT_SIDE
}SteperSideType;

@interface SDStepper : UIView

@property (nonatomic, assign)SteperSideType currentSideModel;

@property (nonatomic, strong,nonnull)NSString* theleftItemText;

@property (nonatomic, strong,nonnull)NSString* theRightItemText;

@property (nonatomic, strong,nonnull)UIColor * stepperBackColor;

- (void)addTarget:(nullable id)target action:(nonnull SEL)action;

- (void)setLeftText:(nonnull NSString * )lefttext rightText:(nonnull NSString * )rightText;
@end




@interface SDStepperSideView : UIView

@property (nonatomic, strong,nonnull)UIColor * stepperBackColor;

@property (nonatomic, strong,readonly,nonnull)CAShapeLayer * backLayer;

@property (nonatomic, assign) SteperSideType sidetype;

@property (nonatomic, strong,nonnull) UILabel * theTitleLabel;

@property (nonatomic, assign) BOOL isSelected;

- (nonnull id)initWithFrame:(CGRect)frame andSideModel:(SteperSideType)type;
- (void)settitleText:(nonnull NSString * )text;

@end