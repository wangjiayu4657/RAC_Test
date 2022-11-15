//
//  ViewModelServiceImpl.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/25.
//

#import "ViewModelServiceImpl.h"
#import "HomeProtocolImpl.h"
#import "BookProtocolImpl.h"


@interface ViewModelServiceImpl()

/** 首页数据获取 */
@property (nonatomic,strong) HomeProtocolImpl *homeService;
/** 消息页服务类 */
@property (nonatomic,strong) BookProtocolImpl *messageService;

@end

@implementation ViewModelServiceImpl

- (instancetype)initModelServiceImpl {
  if (self = [super init]) {
    _homeService = [[HomeProtocolImpl alloc] init];
    _messageService = [[BookProtocolImpl alloc] init];
  }
  return self;
}

- (id<HomeProtocol>)getHomeService {
  return self.homeService;
}

- (id<BookProtocol>)getMessageService {
  return self.messageService;
}





@end
