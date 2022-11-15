//
//  ViewModelService.h
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/25.
//

#import<Foundation/Foundation.h>
#import "HomeProtocol.h"
#import "BookProtocol.h"

@protocol ViewModelService <NSObject>

///获取首页服务类
- (id<HomeProtocol>)getHomeService;

///获取消息页服务类
- (id<BookProtocol>)getMessageService;
		 
@end
