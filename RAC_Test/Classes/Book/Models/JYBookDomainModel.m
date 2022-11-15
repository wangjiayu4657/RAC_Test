//
//  JYBookDomainModel.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/4/2.
//

#import "JYBookDomainModel.h"

@implementation JYBookDomainModel

- (instancetype)init {
  if (self = [super init]) {
    //默认图标
    self.icon = BuilderImg(@"check_normal");
  }
  return self;
}

- (void)setIsSelected:(BOOL)isSelected {
  _isSelected = isSelected;

  self.icon = isSelected ? BuilderImg(@"ture_selected") : BuilderImg(@"check_normal");
}


@end
