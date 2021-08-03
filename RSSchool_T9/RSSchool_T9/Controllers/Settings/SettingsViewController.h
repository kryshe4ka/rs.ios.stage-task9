//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Liza Kryshkovskaya
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import <UIKit/UIKit.h>
#import "ColorDelegate.h"
#import "SwitcherDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ColorDelegate>

@property(weak, nonatomic) id<SwitcherDelegate> delegateKL;
@property(weak, nonatomic) id<ColorDelegate> delegateColor;

@end

NS_ASSUME_NONNULL_END
