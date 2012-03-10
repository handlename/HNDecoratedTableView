#import "SampleController.h"
#import "HNDecoratedTableView.h"

@implementation SampleController

@synthesize table = table_;

#pragma mark Override

-(void)viewDidLoad {
    [super viewDidLoad];

    self.table.dataSource = self;
    self.table.delegate = self;

    self.table.separatorHeight = 2.0;
    self.table.separatorOffsetLeft = 2.0;
    self.table.separatorOffsetRight = 2.0;
    self.table.separatorColor = [UIColor colorWithRed:201.0 / 255.0
                                                green:66.0 / 255.0
                                                 blue:13.0 / 255.0
                                                alpha:1.0];
}

-(void)releaseIBOutlets {
    self.table.dataSource = nil;
    self.table.delegate = nil;
    self.table = nil;
    [super releaseIBOutlets];
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return section + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* IDENT = @"CELL";

    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:IDENT];

    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:IDENT];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"cell %d-%d", indexPath.section + 1, indexPath.row + 1];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    [self.table setBackgroundImage:[UIImage imageNamed:@"cell_bg.png"]
                        withInsets:UIEdgeInsetsMake(8, 8, 7, 7)
                           forCell:cell
                 forRowAtIndexPath:indexPath];
}

@end
