//
//  JYOptionsView.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/1.
//

#import "BaseView.h"
@class HomeViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface JYOptionsView : BaseView
/** 视图模型 */
@property (nonatomic,strong) HomeViewModel *viewModel;
/** 数据源信号 */
@property (nonatomic,strong) RACSignal *sourceSignal;
/** 更新collectionView的高度 */
@property (nonatomic,strong) RACSubject *updateHeightSignal;

@end

NS_ASSUME_NONNULL_END
