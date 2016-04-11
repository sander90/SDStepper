//
//  SDStepper.m
//  SDStepper
//
//  Created by shansander on 16/4/10.
//  Copyright © 2016年 shansander. All rights reserved.
//

#import "SDStepper.h"


#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)
const static float widthOfstepperView = 100.0f;
const static float heightOfstepperView = 30.0f;

@interface SDStepper ()

@property (nonatomic, strong) SDStepperSideView * theSepper1View;

@property (nonatomic, strong) SDStepperSideView * theSepper2View;

@property (nonatomic, strong,nullable) id target;

@property (nonatomic, assign) SEL action;
@end

@implementation SDStepper

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, widthOfstepperView, heightOfstepperView);
        self.backgroundColor = [UIColor clearColor];
        [self buildingStepperView];
    }
    return self;
}
- (void)buildingStepperView
{
    CGRect leftRect =CGRectMake(0, 0, widthOfstepperView/2.0f, heightOfstepperView);
    CGRect rightRect =CGRectMake(widthOfstepperView/2.0f, 0, widthOfstepperView/2.0f, heightOfstepperView);
    
    self.theSepper1View = [[SDStepperSideView alloc] initWithFrame:leftRect andSideModel:STEPPER_LEFT_SIDE];
    [self addSubview:self.theSepper1View];
    self.theSepper2View = [[SDStepperSideView alloc] initWithFrame:rightRect andSideModel:STEPPER_RIGHT_SIDE];
    [self addSubview:self.theSepper2View];
}

- (void)setLeftText:(NSString * )lefttext rightText:(NSString * )rightText
{
    _theleftItemText = lefttext;
    _theRightItemText = rightText;
    
    [self.theSepper1View settitleText:self.theleftItemText];
    [self.theSepper2View settitleText:self.theRightItemText];
}
- (void)setStepperBackColor:(UIColor *)StepperBackColor
{
    _stepperBackColor = StepperBackColor;
    self.theSepper1View.stepperBackColor = self.stepperBackColor;
    self.theSepper2View.stepperBackColor = self.stepperBackColor;
}


- (void)addTarget:(nullable id)target action:(nonnull SEL)action
{
    _target = target;
    _action = action;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint  touchPoint = [touch locationInView:self];
    if ([self getTouchIsInRightItemWithTouchPoint:touchPoint]) {
        // 点击到左边按钮
        [self touchLeftItem];
    }else{
        // 点击到右边按钮
        [self touchRightItem];
    }
}

- (BOOL)getTouchIsInRightItemWithTouchPoint:(CGPoint)p
{
    if (CGRectContainsPoint(self.theSepper1View.frame, p)) {
        return YES;
    }
    return NO;
}
- (void)touchLeftItem
{
    if (self.currentSideModel == STEPPER_LEFT_SIDE) {
        // 不需要改变什么
    }else{
        self.currentSideModel = STEPPER_LEFT_SIDE;
        self.theSepper1View.isSelected = YES;
        self.theSepper2View.isSelected = NO;
        if (self.target) {
            SuppressPerformSelectorLeakWarning(
                [self.target performSelector:self.action withObject:self];
            );
        }
    }
}
- (void)touchRightItem
{
    if (self.currentSideModel == STEPPER_RIGHT_SIDE) {
        // 不需要改变什么
    }else{
        self.currentSideModel = STEPPER_RIGHT_SIDE;
        self.theSepper2View.isSelected = YES;
        self.theSepper1View.isSelected = NO;
        if (self.target) {
            SuppressPerformSelectorLeakWarning(
                                               [self.target performSelector:self.action withObject:self];
                                               );
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@implementation SDStepperSideView

- (id)initWithFrame:(CGRect)frame andSideModel:(SteperSideType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sidetype = type;
        self.backgroundColor = [UIColor clearColor];
        [self buildingSideView];
        
    }
    return self;
}
#pragma mark - 设置背景颜色
- (void)setStepperBackColor:(UIColor *)StepperBackColor
{
    _stepperBackColor = StepperBackColor;
    
    self.backLayer.fillColor = self.stepperBackColor.CGColor;
    
}
- (void)settitleText:(NSString * )text
{
    self.theTitleLabel.text = text;
}
- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (self.isSelected) {
        self.backLayer.fillColor = [UIColor whiteColor].CGColor;
        self.theTitleLabel.textColor = self.stepperBackColor;
    }else{
        self.backLayer.fillColor = self.stepperBackColor.CGColor;
        self.theTitleLabel.textColor = [UIColor whiteColor];
    }
}

- (void)buildingSideView
{
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = [self GetBoardPath];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    _backLayer = shapeLayer;
    
    UILabel * thelabel = [[UILabel alloc] initWithFrame:self.bounds];
    thelabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:thelabel];
    thelabel.textAlignment = NSTextAlignmentCenter;
    thelabel.textColor = [UIColor whiteColor];
    self.theTitleLabel = thelabel;
}
- (CGPathRef)GetBoardPath
{
    if (self.sidetype == STEPPER_LEFT_SIDE) {
        CGRect pathRect = CGRectMake(1, 1, self.bounds.size.width - 1, self.bounds.size.height - 2);

        UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:pathRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
        return bezierpath.CGPath;
    }else{
        CGRect pathRect = CGRectMake(0, 1, self.bounds.size.width - 1, self.bounds.size.height - 2);
        UIBezierPath * bezierpath = [UIBezierPath bezierPathWithRoundedRect:pathRect byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        return bezierpath.CGPath;
    }
}





@end

