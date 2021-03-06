#import <UIKit/UIKit.h>

@interface HNDecoratedTableView : UITableView

@property (nonatomic, retain) UIColor* separatorColor;
@property (nonatomic, assign) CGFloat separatorOffsetRight;
@property (nonatomic, assign) CGFloat separatorOffsetLeft;
@property (nonatomic, assign) CGFloat separatorHeight;

-(void)setBackgroundImage:(UIImage*)image
               withInsets:(UIEdgeInsets)insets
                  forCell:(UITableViewCell*)cell
        forRowAtIndexPath:(NSIndexPath*)indexPath;

@end
