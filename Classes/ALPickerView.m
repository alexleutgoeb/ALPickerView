//
//  ALPickerView.m
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

#import "ALPickerView.h"
#import "CheckView.h"


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@implementation ALPickerView

@synthesize delegate;


#pragma mark -
#pragma mark NSObject stuff

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
	return [self initWithFrame:CGRectMake(0.f, 0.f, 320.f, 215.f)];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
	// Set fix width and height
	if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 320.f, 215.f)]) {
		self.delegate = nil;
		internalPickerView = [[UIPickerView alloc] init];
		internalPickerView.delegate = self;
		internalPickerView.dataSource = self;
		internalPickerView.showsSelectionIndicator = NO;
		[self addSubview:internalPickerView];
	}
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[internalPickerView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIPickerViewDataSource methods

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return [CheckView viewWidth];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return [CheckView viewHeight];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.delegate numberOfRowsForPickerView:self];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}


#pragma mark -
#pragma mark UIPickerViewDelegate methods

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component 
		   reusingView:(UIView *)view {
	
	CheckView *checkView = (CheckView *)view;
	[checkView removeObserver:self forKeyPath:@"selected"];
	
	
	if (checkView == nil) {
		checkView = [[[CheckView alloc] init] autorelease];
	}
	
	checkView.title = [delegate pickerView:self textForRow:row];
	checkView.selected = [delegate pickerView:self selectionStateForRow:row];
	checkView.tag = row;
	
	// TODO: Required ?
	[checkView setNeedsDisplay];
	
	[checkView addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
	
	return checkView;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change 
					   context:(void *)context {
	
	if ([keyPath isEqualToString:@"selected"]) {
		CheckView *checkView = (CheckView *)object;
		
		BOOL selected = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
		
		if (!selected) {
			if ([self.delegate respondsToSelector:@selector(pickerView:didUncheckRow:)]) {
				[self.delegate pickerView:self didUncheckRow:checkView.tag];
			}
		}
		else {
			if ([self.delegate respondsToSelector:@selector(pickerView:didCheckRow:)]) {
				[self.delegate pickerView:self didCheckRow:checkView.tag];
			}
		}
	}
}

@end
