//
//  MessageViewController.h
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "BaseViewController.h"
@class BookViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface BookViewController : BaseViewController

- (instancetype)initWithViewModel:(BookViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
