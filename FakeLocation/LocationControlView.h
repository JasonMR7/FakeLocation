//
//  LocationControlView.h
//  LocationFaker
//
//  Created by Jason Ruan on 2019/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationControlView : UIView

@property (nonatomic, copy) void (^northButtonClickBlock)(void);
@property (nonatomic, copy) void (^southButtonClickBlock)(void);
@property (nonatomic, copy) void (^westButtonClickBlock)(void);
@property (nonatomic, copy) void (^eastButtonClickBlock)(void);

+ (instancetype)controlView;

@end

NS_ASSUME_NONNULL_END
