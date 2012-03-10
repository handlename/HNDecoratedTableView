#import "HNDecoratedTableView.h"

@interface HNDecoratedTableView ()
-(void)initialize;
+(UIImage*)resizableImageWithCapInsets:(UIEdgeInsets)insets forImage:(UIImage*)image;
+(UIImage*)cropImage:(UIImage*)image toRect:(CGRect)rect;
-(BOOL)isNeedSeparatorAtIndexPath:(NSIndexPath*)indexPath;
-(UIImage*)makeBackgroundImageAtIndexPath:(NSIndexPath*)indexPath withImage:(UIImage*)image withInsets:(UIEdgeInsets)insets;
-(UIView*)makeSeparatorViewForCell:(UITableViewCell*)cell;
@end

@implementation HNDecoratedTableView

@synthesize separatorColor = separatorColor_;
@synthesize separatorOffsetRight = separatorOffsetRight_;
@synthesize separatorOffsetLeft = separatorOffsetLeft_;
@synthesize separatorHeight = separatorHeight_;

-(id)init {
    self = [super init];

    if (self) {
        [self initialize];
    }

    return self;
}

-(id)initWithFrame:(CGRect)rect {
    self = [super initWithFrame:rect];

    if (self) {
        [self initialize];
    }

    return self;
}

-(id)initWithCoder:(NSCoder*)decoder {
    self = [super initWithCoder:decoder];

    if (self) {
        [self initialize];
    }

    return self;
}

-(void)dealloc {
    self.separatorColor = nil;
    [super dealloc];
}

-(void)setBackgroundImage:(UIImage*)image
               withInsets:(UIEdgeInsets)insets
                  forCell:(UITableViewCell*)cell
        forRowAtIndexPath:(NSIndexPath*)indexPath {
    CGRect frame = CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height);

    // background
    UIView* backgroundView = [[UIView alloc] initWithFrame:frame];
    UIImage* backgroundImage = [self makeBackgroundImageAtIndexPath:indexPath
                                                          withImage:image
                                                         withInsets:insets];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:backgroundImage];

    if (self.style == UITableViewStyleGrouped) {
        imageView.frame = CGRectMake(frame.origin.x, frame.origin.y,
                                     frame.size.width - 18.0, frame.size.height);
    }
    else {
        imageView.frame = CGRectMake(frame.origin.x, frame.origin.y,
                                     frame.size.width, frame.size.height);
    }

    [backgroundView addSubview:imageView];

    // sepaator
    if (self.separatorColor && [self isNeedSeparatorAtIndexPath:indexPath]) {
        [backgroundView addSubview:[self makeSeparatorViewForCell:cell]];
    }

    cell.backgroundView = backgroundView;

    [imageView release];
    [backgroundView release];
}

#pragma mark Private

-(void)initialize {
    self.separatorColor = [UIColor clearColor];
    self.separatorHeight = 1.0;
    self.separatorOffsetRight = 0.0;
    self.separatorOffsetLeft = 0.0;
}

+(UIImage*)resizableImageWithCapInsets:(UIEdgeInsets)insets forImage:(UIImage*)image {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];

    if (version < 5.0) {
        return [image stretchableImageWithLeftCapWidth:(insets.left + insets.right) / 2
                                          topCapHeight:(insets.top + insets.bottom) / 2];
    }
    else {
        return [image resizableImageWithCapInsets:insets];
    }
}

+(UIImage*)cropImage:(UIImage*)image toRect:(CGRect)rect {
    CGFloat scale = [UIScreen mainScreen].scale;

    CGRect newRect = CGRectMake(rect.origin.x, rect.origin.y,
                                rect.size.width * scale, rect.size.height * scale);

    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], newRect);
    UIImage* cropped = [UIImage imageWithCGImage:imageRef
                                           scale:image.scale
                                     orientation:image.imageOrientation];
    CGImageRelease(imageRef);

    return cropped;
}

-(BOOL)isNeedSeparatorAtIndexPath:(NSIndexPath*)indexPath {
    NSInteger count = [self.dataSource tableView:self numberOfRowsInSection:indexPath.section];

    if (count == 1) {
        return NO;
    }
    else if (indexPath.row == 0) {
        return YES;
    }
    else if (indexPath.row == (count - 1)) {
        return NO;
    }

    return YES;
}

-(UIImage*)makeBackgroundImageAtIndexPath:(NSIndexPath*)indexPath withImage:(UIImage*)image withInsets:(UIEdgeInsets)insets {
    NSInteger count = [self.dataSource tableView:self numberOfRowsInSection:indexPath.section];

    // make background image by cell's position
    CGRect cropRect;
    UIEdgeInsets resizeInsets;

    if (count == 1) {
        // only one
        cropRect = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
        resizeInsets = insets;
    }
    else if (indexPath.row == 0) {
        // top
        cropRect = CGRectMake(0.0, 0.0,
                              image.size.width,
                              image.size.height - insets.bottom);
        resizeInsets = UIEdgeInsetsMake(insets.top, insets.left, 0.0, insets.right);
    }
    else if (indexPath.row == (count - 1)) {
        // bottom
        cropRect = CGRectMake(0.0,
                              insets.top,
                              image.size.width,
                              image.size.height);
        resizeInsets = UIEdgeInsetsMake(0.0, insets.left, insets.bottom, insets.right);
    }
    else {
        // middle
        cropRect = CGRectMake(0.0,
                              insets.top,
                              image.size.width,
                              image.size.height - (insets.top + insets.bottom));
        resizeInsets = UIEdgeInsetsMake(0.0, insets.left, 0.0, insets.right);
    }

    image = [HNDecoratedTableView cropImage:image toRect:cropRect];
    image = [HNDecoratedTableView resizableImageWithCapInsets:resizeInsets forImage:image];

    return image;
}

-(UIView*)makeSeparatorViewForCell:(UITableViewCell*)cell {
    CGFloat width = cell.backgroundView.frame.size.width;
    width -= self.separatorOffsetLeft;
    width -= self.separatorOffsetRight;

    UIView* separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = self.separatorColor;
    separatorView.frame = CGRectMake(self.separatorOffsetLeft,
                                     cell.backgroundView.frame.size.height - self.separatorHeight,
                                     width,
                                     self.separatorHeight);

    return [separatorView autorelease];
}

@end
