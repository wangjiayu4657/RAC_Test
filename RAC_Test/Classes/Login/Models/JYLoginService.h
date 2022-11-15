//
//  JYLoginProtocolImp.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/1/27.
//

#import "BaseModel.h"
#import "JYLoginProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface JYLoginService : BaseModel<JYLoginProtocol>
- (instancetype)initWithParam:(NSDictionary *)param;
@end

NS_ASSUME_NONNULL_END
