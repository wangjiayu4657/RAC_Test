//
//  JYBookBottomView.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/6.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYBookBottomView : BaseView

/** 预订信号 */
@property (nonatomic,strong) RACCommand *bookCommand;
/** 全选信号 */
@property (nonatomic,strong) RACCommand *allSelectedCommand;

@end

NS_ASSUME_NONNULL_END
