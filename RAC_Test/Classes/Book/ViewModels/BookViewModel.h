//
//  MessageViewModel.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import <Foundation/Foundation.h>
#import "ViewModelService.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookViewModel : NSObject

/** 数据源 */
@property (nonatomic,strong) NSMutableArray *sources;
/** 数据源信号 */
@property (nonatomic,strong) RACCommand *sourceCommand;
/** 是否选中信号 */
@property (nonatomic,strong) RACCommand *didSelectedCommand;
/** 全选信号 */
@property (nonatomic,strong) RACCommand *allSelectedCommand;
/** 选中的信号 */
@property (nonatomic,strong) RACSignal *selectedSetSignal;
/** 预订信号*/
@property (nonatomic,strong) RACCommand *bookCommand;


- (instancetype)initWithService:(id<ViewModelService>)service;

@end

NS_ASSUME_NONNULL_END
