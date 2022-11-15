//
//  HTWebViewModel.m
//  HeartTrip
//
//  Created by 熊彬 on 16/12/13.
//  Copyright © 2016年 BinBear. All rights reserved.
//

#import "HTWebViewModel.h"

@interface HTWebViewModel ()
@property (strong , nonatomic) id<ViewModelService> services;
@end

@implementation HTWebViewModel

- (instancetype)initWithServices:(id<ViewModelService>)services params:(NSDictionary *)params {
    if (self = [super init]) {
        _services = services;
        
        _requestURL = params[RequestURLkey];
        _title = params[WebTitlekey];
        _navBarStyleType = [params[WebNavBarStyleTypekey] unsignedIntegerValue];
        _webType = [params[WebViewTypekey] unsignedIntegerValue];
    }
    return self;
}
@end
