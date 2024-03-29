//
//  FPPopoverView.m
//
//  Created by Alvise Susmel on 1/4/12.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//
//  https://github.com/50pixels/FPPopover


#import "FPPopoverView.h"

#define FP_POPOVER_ARROW_HEIGHT 10.0
#define FP_POPOVER_ARROW_BASE 20.0
#define FP_POPOVER_RADIUS 10.0


@interface FPPopoverView(Private)
-(void)setupViews;
@end


@implementation FPPopoverView
@synthesize title;
@synthesize relativeOrigin;
@synthesize tint = _tint;

-(void)dealloc
{
    self.title = nil;
    [_contentView release];
    [_titleLabel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //we need to set the background as clear to see the view below
        
        self.backgroundColor = [UIColor clearColor];//清除弹出窗口背景
        self.clipsToBounds = YES;
        
        self.layer.shadowOpacity = 0.7;
        self.layer.shadowRadius = 5;
        self.layer.shadowOffset = CGSizeMake(-3, 3);

        //to get working the animations
        self.contentMode = UIViewContentModeRedraw;
        
        
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        _titleLabel.textColor = [UIColor whiteColor];
//        _titleLabel.textAlignment = UITextAlignmentCenter;
//        _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
        
        self.tint = FPPopoverDefaultTint;
        
        [self addSubview:_titleLabel];
        [self setupViews];
    }
    return self;
}

#pragma mark setters
-(void)setArrowDirection:(FPPopoverArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    [self setNeedsDisplay];
}

-(FPPopoverArrowDirection)arrowDirection
{
    return _arrowDirection;
}
-(void)addContentView:(UIView *)contentView
{
    if(_contentView != contentView)
    {
        [_contentView removeFromSuperview];
        [_contentView release];
        _contentView = [contentView retain];
        [self addSubview:_contentView];
    }
    [self setupViews];
}

#pragma mark drawing

//the content with the arrow
-(CGPathRef)createContentPathWithBorderWidth:(CGFloat)borderWidth arrowDirection:(FPPopoverArrowDirection)direction
{
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat ah = FP_POPOVER_ARROW_HEIGHT; //is the height of the triangle of the arrow
    CGFloat aw = FP_POPOVER_ARROW_BASE/2.0; //is the 1/2 of the base of the arrow
    CGFloat radius = FP_POPOVER_RADIUS;
    CGFloat b = borderWidth;
    
    CGRect rect;
    if(direction == FPPopoverArrowDirectionUp)
    {
        
        rect.size.width = w - 2*b;
        rect.size.height = h - ah - 2*b;
        rect.origin.x = b;
        rect.origin.y = ah + b;        
    }
    else if(direction == FPPopoverArrowDirectionDown)
    {
        rect.size.width = w - 2*b;
        rect.size.height = h - ah - 2*b;
        rect.origin.x = b;
        rect.origin.y = b;                
    }
    
    
    else if(direction == FPPopoverArrowDirectionRight)
    {
        rect.size.width = w - ah - 2*b;
        rect.size.height = h - 2*b;
        rect.origin.x = b;
        rect.origin.y = b;                
    }
    else if(direction == FPPopoverArrowDirectionLeft)
    {
        rect.size.width = w - ah - 2*b;
        rect.size.height = h - 2*b;
        rect.origin.x = ah + b;
        rect.origin.y = b;                
    }
    
    //the arrow will be near the origin
    CGFloat ax = self.relativeOrigin.x - aw; //the start of the arrow when UP or DOWN
    if(ax < aw + b) ax = aw + b;
    else if (ax +2*aw + 2*b> self.bounds.size.width) ax = self.bounds.size.width - 2*aw - 2*b;

    CGFloat ay = self.relativeOrigin.y - aw; //the start of the arrow when RIGHT or LEFT
    if(ay < aw + b) ay = aw + b;
    else if (ay +2*aw + 2*b > self.bounds.size.height) ay = self.bounds.size.height - 2*aw - 2*b;
    
    
    //ROUNDED RECT
    // arrow UP
    CGRect innerRect = CGRectInset(rect, radius, radius);
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = rect.origin.x + rect.size.width;
	CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom = rect.origin.y + rect.size.height;    
	CGFloat inside_top = innerRect.origin.y;
	CGFloat outside_top = rect.origin.y;
	CGFloat outside_left = rect.origin.x;

    
    //drawing the border with arrow
    CGMutablePathRef path = CGPathCreateMutable();

    CGPathMoveToPoint(path, NULL, innerRect.origin.x, outside_top);
 
    //top arrow
    if(direction == FPPopoverArrowDirectionUp)
    {
        CGPathAddLineToPoint(path, NULL, ax, ah+b);
        CGPathAddLineToPoint(path, NULL, ax+aw, b);
        CGPathAddLineToPoint(path, NULL, ax+2*aw, ah+b);
        
    }
    

    CGPathAddLineToPoint(path, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(path, NULL, outside_right, outside_top, outside_right, inside_top, radius);

    //right arrow
    if(direction == FPPopoverArrowDirectionRight)
    {
        CGPathAddLineToPoint(path, NULL, outside_right, ay);
        CGPathAddLineToPoint(path, NULL, outside_right + ah+b, ay + aw);
        CGPathAddLineToPoint(path, NULL, outside_right, ay + 2*aw);
    }
       

	CGPathAddLineToPoint(path, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(path, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, radius);

    //down arrow
    if(direction == FPPopoverArrowDirectionDown)
    {
        CGPathAddLineToPoint(path, NULL, ax+2*aw, outside_bottom);
        CGPathAddLineToPoint(path, NULL, ax+aw, outside_bottom + ah);
        CGPathAddLineToPoint(path, NULL, ax, outside_bottom);
    }

	CGPathAddLineToPoint(path, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(path, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, radius);
    
    //left arrow
    if(direction == FPPopoverArrowDirectionLeft)
    {
        CGPathAddLineToPoint(path, NULL, outside_left, ay + 2*aw);
        CGPathAddLineToPoint(path, NULL, outside_left - ah-b, ay + aw);
        CGPathAddLineToPoint(path, NULL, outside_left, ay);
    }
    

	CGPathAddLineToPoint(path, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(path, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, radius);

    
    CGPathCloseSubpath(path);
    
    return path;
}



-(CGGradientRef)createGradient
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // make a gradient
    CGFloat colors[8];
    
    colors[0] = 1; colors[1] = 1; colors[2] = 1;
    colors[4] = 1; colors[5] = 1;  colors[6] = 1;
    colors[3] = colors[7] = 1;
    

    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);

    CFRelease(colorSpace);
    return gradient;
}



- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGGradientRef gradient = [self createGradient];
    [[UIColor whiteColor] set];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();    
    CGContextSaveGState(ctx);
   
    //content fill
    CGPathRef contentPath = [self createContentPathWithBorderWidth:2.0 arrowDirection:_arrowDirection];
    
    CGContextAddPath(ctx, contentPath);    
    CGContextClip(ctx);

    //  Draw a linear gradient from top to bottom
    CGPoint start;
    CGPoint end;
    if(_arrowDirection == FPPopoverArrowDirectionUp)
    {
        start = CGPointMake(self.bounds.size.width/2.0, 0);
        end = CGPointMake(self.bounds.size.width/2.0,40);
    }
    else 
    {
        start = CGPointMake(self.bounds.size.width/2.0, 0);
        end = CGPointMake(self.bounds.size.width/2.0,20);
    }


    
   CGContextDrawLinearGradient(ctx, gradient, start, end, 0);
    
    CGGradientRelease(gradient);
    //fill the other part of path

    
   CGContextFillRect(ctx, CGRectMake(0, end.y, self.bounds.size.width, self.bounds.size.height-end.y));
    //internal border
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, contentPath);
    CGContextSetRGBStrokeColor(ctx, 0.7, 0.7, 0.7, 1.0);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx,kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
    CGPathRelease(contentPath);

//    //external border
    CGPathRef externalBorderPath = [self createContentPathWithBorderWidth:1.0 arrowDirection:_arrowDirection];
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, externalBorderPath);
    CGContextSetRGBStrokeColor(ctx, 0.4, 0.4, 0.4, 1.0);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx,kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
    CGPathRelease(externalBorderPath);
//
//    //3D border of the content view
    CGRect cvRect = _contentView.frame;
    //firstLine
    CGContextSetRGBStrokeColor(ctx, 0.7, 0.7, 0.7, 1.0);
    CGContextStrokeRect(ctx, cvRect);
    //secondLine
    cvRect.origin.x -= 1; cvRect.origin.y -= 1; cvRect.size.height += 2; cvRect.size.width += 2;
    CGContextSetRGBStrokeColor(ctx, 0.4, 0.4, 0.4, 1.0);
    CGContextStrokeRect(ctx, cvRect);

    
    
    CGContextRestoreGState(ctx);
}

#pragma mark ----------------子视图起始位置设置
-(void)setupViews
{
    //content posizion and size
    CGRect contentRect = _contentView.frame;

    if(_arrowDirection == FPPopoverArrowDirectionUp)
    {
        contentRect.origin = CGPointMake(0, 1);
        contentRect.size = CGSizeMake(self.bounds.size.width-20, self.bounds.size.height-35);
        _titleLabel.frame = CGRectMake(10, 30, self.bounds.size.width-20, 20);        
    }
    else if(_arrowDirection == FPPopoverArrowDirectionDown)
    {
        contentRect.origin = CGPointMake(10, 40);        
        contentRect.size = CGSizeMake(self.bounds.size.width-20, self.bounds.size.height-70);
        _titleLabel.frame = CGRectMake(10, 10, self.bounds.size.width-20, 20);           
    }
    
    
    else if(_arrowDirection == FPPopoverArrowDirectionRight)
    {
        contentRect.origin = CGPointMake(10, 40);        
        contentRect.size = CGSizeMake(self.bounds.size.width-40, self.bounds.size.height-50);
        _titleLabel.frame = CGRectMake(10, 10, self.bounds.size.width-20, 20);           
    }

    else if(_arrowDirection == FPPopoverArrowDirectionLeft)
    {
        contentRect.origin = CGPointMake(10 + FP_POPOVER_ARROW_HEIGHT, 40);        
        contentRect.size = CGSizeMake(self.bounds.size.width-40, self.bounds.size.height-50);
        _titleLabel.frame = CGRectMake(10, 10, self.bounds.size.width-20, 20);           
    }

    _contentView.frame = contentRect;
    _titleLabel.text = self.title;    
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setupViews];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    //[self setupViews];
}

-(void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self setupViews];
}
@end
