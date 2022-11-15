//
//  LoginViewModel.h
//  RAC_Test
//
//  Created by wangjiayu on 2021/12/16.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : BaseModel
/** 密码 */
@property (nonatomic,strong) NSString *pwd;
/** 用户名 */
@property (nonatomic,strong) NSString *user;

/** 登录按钮使能信号 */
@property (nonatomic,strong) RACSignal *enableSignal;
/** 登录执行命令 */
@property (nonatomic,strong) RACCommand *command;

@end

NS_ASSUME_NONNULL_END
