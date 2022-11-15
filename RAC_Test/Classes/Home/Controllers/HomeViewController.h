//
//  HomeViewController.h
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "BaseViewController.h"

@class HomeViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : BaseViewController

- (instancetype)initWithViewModel:(HomeViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
