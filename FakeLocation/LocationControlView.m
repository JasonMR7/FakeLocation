//
//  LocationControlView.m
//  LocationFaker
//
//  Created by Jason Ruan on 2019/1/15.
//

#import "LocationControlView.h"

static CGFloat const kLocationControlViewWidthHeight = 70 * 3;
static CGFloat const kLocationControlButtonWidthHeight = 70;

@interface LocationControlView()

@end

@implementation LocationControlView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self __setUpUI];
    }
    return self;
}

#pragma mark - Public Methods

+ (instancetype)controlView {
    LocationControlView *controlView = [[LocationControlView alloc] initWithFrame:CGRectMake(0, 0, kLocationControlViewWidthHeight, kLocationControlViewWidthHeight)];
    return controlView;;
}

#pragma mark - Private Methods

- (void)__setUpUI {
    // North Button
    {
        UIButton *goNorthButton = [self directionButton];
        [goNorthButton setTitle:@"north" forState:UIControlStateNormal];
        [goNorthButton addTarget:self action:@selector(__didClickGoNorthButton) forControlEvents:UIControlEventTouchUpInside];
        goNorthButton.frame = CGRectMake(kLocationControlButtonWidthHeight, 0, kLocationControlButtonWidthHeight, kLocationControlButtonWidthHeight);
        [self addSubview:goNorthButton];
    }
    
    // South Button
    {
        UIButton *sourceButton = [self directionButton];
        [sourceButton setTitle:@"source" forState:UIControlStateNormal];
        [sourceButton addTarget:self action:@selector(__didClickGoSouthButton) forControlEvents:UIControlEventTouchUpInside];
        sourceButton.frame = CGRectMake(kLocationControlButtonWidthHeight, kLocationControlButtonWidthHeight * 2, kLocationControlButtonWidthHeight, kLocationControlButtonWidthHeight);
        [self addSubview:sourceButton];
    }
    
    // East Button
    {
        UIButton *eastButton = [self directionButton];
        [eastButton setTitle:@"east" forState:UIControlStateNormal];
        [eastButton addTarget:self action:@selector(__didClickGoEastButton) forControlEvents:UIControlEventTouchUpInside];
        eastButton.frame = CGRectMake(kLocationControlButtonWidthHeight * 2, kLocationControlButtonWidthHeight, kLocationControlButtonWidthHeight, kLocationControlButtonWidthHeight);
        [self addSubview:eastButton];
    }
    
    // West Button
    {
        UIButton *westButton = [self directionButton];
        [westButton setTitle:@"west" forState:UIControlStateNormal];
        [westButton addTarget:self action:@selector(__didClickGoWestButton) forControlEvents:UIControlEventTouchUpInside];
        westButton.frame = CGRectMake(0, kLocationControlButtonWidthHeight, kLocationControlButtonWidthHeight, kLocationControlButtonWidthHeight);
        [self addSubview:westButton];
    }
}

- (void)__didClickGoNorthButton {
    if (self.northButtonClickBlock) {
        self.northButtonClickBlock();
    }
}

- (void)__didClickGoSouthButton {
    if (self.southButtonClickBlock) {
        self.southButtonClickBlock();
    }
}

- (void)__didClickGoEastButton {
    if (self.eastButtonClickBlock) {
        self.eastButtonClickBlock();
    }
}

- (void)__didClickGoWestButton {
    if (self.westButtonClickBlock) {
        self.westButtonClickBlock();
    }
}

#pragma mark - Getter or Setter

- (UIButton *)directionButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    button.layer.borderWidth = 1;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

@end
