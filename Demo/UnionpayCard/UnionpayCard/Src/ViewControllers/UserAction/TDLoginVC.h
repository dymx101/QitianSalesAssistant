//
//  TDLoginVC.h
//  UnionpayCard
//
//  Created by Dong Yiming on 2/21/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDBaseVC.h"

@protocol TDLoginVCDelegate <NSObject>

- (void) getProfile:(NSString *) tOken;

@end

@interface TDLoginVC : TDBaseVC

@property(nonatomic,weak) id<TDLoginVCDelegate> delegate;

@end
