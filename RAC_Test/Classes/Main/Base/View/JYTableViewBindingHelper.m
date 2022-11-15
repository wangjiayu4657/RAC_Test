//
//  JYTableViewBindingHelper.m
//  RAC_Test
//
//  Created by wangjiayu on 2022/3/30.
//

#import "JYTableViewBindingHelper.h"
#import "JYReactiveViewDelegate.h"

@interface JYTableViewBindingHelper()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSArray *sources;
/** 选中时的命令 */
@property (nonatomic,strong) RACCommand *didSelectedCommand;
/** cell重用标识 */
@property (nonatomic,strong) NSString *cellIdentifier;
/** cell重用标识 */
@property (nonatomic,strong) NSString *headerIdentifier;
/** cell重用标识 */
@property (nonatomic,strong) NSString *footerIdentifier;
/** 是否为分组 */
@property (nonatomic,assign) BOOL isGroup;
/** 视图模型 */
@property (nonatomic,strong) id viewModel;

@end


@implementation JYTableViewBindingHelper

#pragma mark - init

- (instancetype)initWithTable:(UITableView *)tableView
                         cell:(Class)cell
                sectionHeader:(Class)sectionHeader
                sectionFooter:(Class)sectionFooter
              			   source:(RACSignal *)source
                withViewModel:(id)viewModel
                        param:(NSDictionary *)param
              selectedCommand:(RACCommand *)didSelectedCommand {
  
  if (self = [super init]) {
    self.tableView = tableView;
    self.sources = [NSArray array];
    self.didSelectedCommand = didSelectedCommand;
    self.viewModel = viewModel;
    self.isGroup = NO;
  }
  
  @weakify(self)
  [source subscribeNext:^(id  _Nullable x) {
    @strongify(self)
    self.sources = x;
    [self.tableView reloadData];
  }];
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  NSString *cellType = param[@"cellType"];
  self.cellIdentifier = NSStringFromClass(cell);
  
  NSString *headerType = param[@"headerType"];
  self.headerIdentifier = NSStringFromClass(sectionHeader);
  
  NSString *footerType = param[@"footerType"];
  self.footerIdentifier = NSStringFromClass(sectionFooter);
  
  self.isGroup = [self.headerIdentifier isNotBlank] || [self.footerIdentifier isNotBlank];
  
  //注册cell
  if ([cellType isEqualToString:@"codeType"]) {
    Class codeCell = NSClassFromString(self.cellIdentifier);
    [self.tableView registerClass:codeCell forCellReuseIdentifier:self.cellIdentifier];
  } else {
    UINib *nibCell = [UINib nibWithNibName:self.cellIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:self.cellIdentifier];
  }
  
  //注册组头
  if([self.headerIdentifier isNotBlank]){
    if ([headerType isEqualToString:@"codeType"]) {
      Class codeHeader = NSClassFromString(self.headerIdentifier);
      [self.tableView registerClass:codeHeader forHeaderFooterViewReuseIdentifier:self.headerIdentifier];
    } else {
      UINib *nibHeader = [UINib nibWithNibName:self.headerIdentifier bundle:nil];
      [self.tableView registerNib:nibHeader forHeaderFooterViewReuseIdentifier:self.headerIdentifier];
    }
  }
  
  //注册组尾
  if([self.footerIdentifier isNotBlank]){
    if ([footerType isEqualToString:@"codeType"]) {
      Class codeFooter = NSClassFromString(self.footerIdentifier);
      [self.tableView registerClass:codeFooter forHeaderFooterViewReuseIdentifier:self.footerIdentifier];
    } else {
      UINib *nibFooter = [UINib nibWithNibName:self.footerIdentifier bundle:nil];
      [self.tableView registerNib:nibFooter forHeaderFooterViewReuseIdentifier:self.footerIdentifier];
    }
  }
  
  return self;
}

- (void)setReloadSignal:(RACSignal *)reloadSignal {
  _reloadSignal = reloadSignal;
  
  @weakify(self)
  [reloadSignal subscribeNext:^(id _Nullable x) {
    @strongify(self)
      [self.tableView reloadData];
  }];
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                 codeCell:(Class)codeCell
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand {
  
  NSDictionary *param = @{@"cellType":@"codeType"};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                                    cell:codeCell
                                           sectionHeader:nil
                                           sectionFooter:nil
                                                  source:source
                                           withViewModel:viewModel
                                                   param:param
                                         selectedCommand:didSelectCommand];
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                  nibCell:(Class)nibCell
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand {
  
  NSDictionary *param = @{@"cellType":@"nibType"};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                                    cell:nibCell
                                           sectionHeader:nil
                                           sectionFooter:nil
                                                  source:source
                                           withViewModel:viewModel
                                                   param:param
                                         selectedCommand:didSelectCommand];
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                 codeCell:(Class)codeCell
                            sectionHeader:(Class)sectionHeader
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand {
  
  NSDictionary *param = @{@"cellType":@"codeType",@"headerType":@"codeType"};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                                    cell:codeCell
                                           sectionHeader:sectionHeader
                                           sectionFooter:nil
                                                  source:source
                                           withViewModel:viewModel
                                                   param:param
                                         selectedCommand:didSelectCommand];
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                  nibCell:(Class)nibCell
                         nibSectionHeader:(Class)nibSectionHeader
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand {
  
  NSDictionary *param = @{@"cellType":@"nibType",@"headerType":@"nibType"};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                                    cell:nibCell
                                           sectionHeader:nibSectionHeader
                                           sectionFooter:nil
                                                  source:source
                                           withViewModel:viewModel
                                                   param:param
                                         selectedCommand:didSelectCommand];
}


+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                 codeCell:(Class)codeCell
                            sectionFooter:(Class)sectionFooter
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand {
  
  NSDictionary *param = @{@"cellType":@"codeType",@"footerType":@"codeType"};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                                    cell:codeCell
                                           sectionHeader:nil
                                           sectionFooter:sectionFooter
                                                  source:source
                                           withViewModel:viewModel
                                                   param:param
                                         selectedCommand:didSelectCommand];
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                  nibCell:(Class)nibCell
                         nibSectionFooter:(Class)nibSectionFooter
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand {
  
  NSDictionary *param = @{@"cellType":@"nibType",@"footerType":@"nibType"};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                                    cell:nibCell
                                           sectionHeader:nil
                                           sectionFooter:nibSectionFooter
                                                  source:source
                                           withViewModel:viewModel
                                                   param:param
                                         selectedCommand:didSelectCommand];
}


+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                 codeCell:(Class)codeCell
                            sectionHeader:(Class)sectionHeader
                            sectionFooter:(Class)sectionFooter
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand {
  
  NSDictionary *param = @{@"cellType":@"codeType",@"headerType":@"codeType",@"footerType":@"codeType"};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                                    cell:codeCell
                                           sectionHeader:sectionHeader
                                           sectionFooter:sectionFooter
                                                  source:source
                                           withViewModel:viewModel
                                                   param:param
                                         selectedCommand:didSelectCommand];
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
                                  nibCell:(Class)nibCell
                         nibSectionHeader:(Class)nibSectionHeader
                         nibSectionFooter:(Class)nibSectionFooter
                                   source:(RACSignal *)source
                            withViewModel:(id _Nullable)viewModel
                         selectionCommand:(RACCommand * _Nullable)didSelectCommand {
  
  NSDictionary *param = @{@"cellType":@"nibType",@"headerType":@"nibType",@"footerType":@"nibType"};
  return [[JYTableViewBindingHelper alloc] initWithTable:tableView
                                                    cell:nibCell
                                           sectionHeader:nibSectionHeader
                                           sectionFooter:nibSectionFooter
                                                  source:source
                                           withViewModel:viewModel
                                                   param:param
                                         selectedCommand:didSelectCommand];
}


#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.isGroup ? self.sources.count : 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *temp = self.isGroup ? self.sources[section] : self.sources;
  return temp.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  id<JYReactiveViewDelegate> header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerIdentifier];
  [header bindModel:self.viewModel withParam:@{DataSection:@(section)}];
  return (UIView *)header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  id<JYReactiveViewDelegate> footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerIdentifier];
  [footer bindModel:self.viewModel withParam:@{DataSection:@(section)}];
  return (UIView *)footer;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  id<JYReactiveViewDelegate> cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
  
  id model = [self catchModelWithIndexPath:indexPath];
  [self handlerDelegate:cell sendModel:model indexPath:indexPath];
  
  return (UITableViewCell *)cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  id model = self.isGroup ? self.sources[indexPath.section][indexPath.item] : self.sources[indexPath.item];
  [self.didSelectedCommand execute:model];
  
  if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
  }
}

#pragma mark - UITableViewDelegate forwarding

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
    [self.delegate scrollViewDidScroll:scrollView];
  }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
  if ([self.delegate respondsToSelector:aSelector]) {
    return YES;
  }
  return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
  if ([self.delegate respondsToSelector:aSelector]) {
    return self.delegate;
  }
  return [super forwardingTargetForSelector:aSelector];
}

- (void)handlerDelegate:(id<JYReactiveViewDelegate>)delegate sendModel:(id)model indexPath:(NSIndexPath *)indexPath {
  NSDictionary *param = @{ModelOfIndexPath:indexPath};
  if ([delegate respondsToSelector:@selector(bindViewModel:model:withParam:)]) {
    [delegate bindViewModel:self.viewModel model:model withParam:param];
  } else if ([delegate respondsToSelector:@selector(bindModel:withParam:)]) {
    [delegate bindModel:model withParam:param];
  } else if ([delegate respondsToSelector:@selector(bindModel:)]) {
    [delegate bindModel:model];
  }
}

- (id)catchModelWithIndexPath:(NSIndexPath *)indexPath {
  id model = nil;
  
  if(self.isGroup) {
    if(indexPath.section < self.sources.count){
      NSArray *temp = self.sources[indexPath.section];
      if(indexPath.item < temp.count){
        model = temp[indexPath.item];
      }
    }
  } else {
    if(indexPath.item < self.sources.count) {
      model = self.sources[indexPath.item];
    }
  }
  
  return model;
}

@end
