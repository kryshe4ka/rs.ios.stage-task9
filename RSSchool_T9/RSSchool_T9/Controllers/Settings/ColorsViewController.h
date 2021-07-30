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

NS_ASSUME_NONNULL_BEGIN

@interface ColorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) id<ColorDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
