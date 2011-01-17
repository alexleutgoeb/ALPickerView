//
//  CheckView.m
//
//  Created by Alex Leutgöb on 16.01.11.
//  Copyright 2011 alexleutgoeb.com. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "CheckView.h"
#import "CustomTapGestureRecognizer.h"


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@interface CheckView ()

@property (nonatomic, retain) UIImage *checkImage;
@property (nonatomic, retain) UIColor *labelColor;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@implementation CheckView

@synthesize title, selected, checkImage, labelColor;

const CGFloat kViewWidth = 298.f;
const CGFloat kViewHeight = 44.f;


#pragma mark -
#pragma mark NSObjects stuff

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
	if (self = [super initWithFrame:CGRectMake(0.0, 0.0, kViewWidth, kViewHeight)])	{
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = NO;
		
		self.checkImage = [UIImage imageNamed:@"check.png"];
		grayBlueColor = [[UIColor colorWithRed:33./256. green:80./256. blue:134./256. alpha:1.f] retain];
		self.labelColor = [UIColor blackColor];
		selected = NO;
	}
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[gestureRec removeObserver:self forKeyPath:@"state"];
	[gestureRec release];	
	[title release];
	[checkImage release];
	
	[labelColor release];
	[grayBlueColor release];
	
	[super dealloc];
}


#pragma mark -
#pragma mark UIView stuff

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didMoveToSuperview {
	gestureRec = [[CustomTapGestureRecognizer alloc] initWithTarget:nil action:nil];
	gestureRec.numberOfTapsRequired = 1;
	[gestureRec addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
	[[self superview] addGestureRecognizer:gestureRec];	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGFloat fontSize = 25.5;
	
	CGFloat yCoord = (self.bounds.size.height - self.checkImage.size.height) / 2;
	
	// draw the image and title using their draw methods
	if (selected) {
		[self.checkImage drawAtPoint:CGPointMake(14.0, yCoord)];
	}
	
	
	yCoord = (self.bounds.size.height - fontSize) / 2;
	CGPoint point = CGPointMake(14.0 + self.checkImage.size.width + 6.0, yCoord);
	
	[self.labelColor set];
	
	[self.title drawAtPoint:point forWidth:self.bounds.size.width withFont:[UIFont boldSystemFontOfSize:fontSize]
				minFontSize:fontSize actualFontSize:NULL lineBreakMode:UILineBreakModeTailTruncation
		 baselineAdjustment:UIBaselineAdjustmentAlignBaselines];	
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)viewWidth {
    return kViewWidth;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)viewHeight {
    return kViewHeight;
}


#pragma mark -
#pragma mark Other methods

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Override selected setter to allow the setting of initial label color
- (void)setSelected:(BOOL)aSelected {
	selected = aSelected;
	if (selected) {
		self.labelColor = grayBlueColor;
	}
	else {
		self.labelColor = [UIColor blackColor];
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change 
					   context:(void *)context {
	
	if ([keyPath isEqualToString:@"state"]) {
		int newKey = [[change objectForKey:NSKeyValueChangeNewKey] intValue];
		
		if (newKey == UIGestureRecognizerStatePossible) {
			// Tap begins, switch elements states to hover
			self.labelColor = [UIColor whiteColor];
			// Delay the color change because of also delayed blue selection style
			[self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.15];
			self.checkImage = [UIImage imageNamed:@"check_white.png"];
		}
		else if (newKey == UIGestureRecognizerStateEnded) {
			// Tap ended, change selection state and redraw elements
			self.selected = !self.selected;
			self.checkImage = [UIImage imageNamed:@"check.png"];
			if (selected) {
				self.labelColor = grayBlueColor;
			}
			else {
				self.labelColor = [UIColor blackColor];
			}
			[self setNeedsDisplay];
		}
		else {
			// Tap cancelled, restore element state
			self.checkImage = [UIImage imageNamed:@"check.png"];
			if (selected) {
				self.labelColor = grayBlueColor;
			}
			else {
				self.labelColor = [UIColor blackColor];
			}
			[self setNeedsDisplay];
		}
	}
}

@end
