#import "BaseController.h"

@class HNDecoratedTableView;

@interface SampleController : BaseController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) IBOutlet HNDecoratedTableView* table;
@end
