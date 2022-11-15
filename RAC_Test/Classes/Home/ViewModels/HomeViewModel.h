//
//  HomeViewModel.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/25.
//

#import <Foundation/Foundation.h>
#import "ViewModelService.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject
/** banner图 */
@property (nonatomic,strong) RACCommand *bannerCommand;
/** 域名数据 */
@property (nonatomic,strong) RACCommand *domainCommand;
/** 操作数据 */
@property (nonatomic,strong) RACCommand *optionCommand;

- (instancetype)initWithService:(id<ViewModelService>)service;

@end

NS_ASSUME_NONNULL_END
