//
//  JYJsonManager.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/1.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYJsonManager : BaseModel

//加载
+ (RACSignal *)loadDataWithFileName:(NSString *)fileName;

+ (RACSignal *)loadDataWithFileName:(NSString *)fileName toModel:(NSString *)modelName;


@end

NS_ASSUME_NONNULL_END
