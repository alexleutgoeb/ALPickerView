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

@synthesize delegate, allOption, allOptionTitle;


#pragma mark -
#pragma mark NSObject stuff

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
	return [self initWithFrame:CGRectMake(0.f, 0.f, 320.f, 215.f)];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
	// Set fix width and height
	if ((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 320.f, 215.f)])) {
		self.delegate = nil;
		internalPickerView = [[UIPickerView alloc] init];
		internalPickerView.delegate = self;
		internalPickerView.dataSource = self;
		internalPickerView.showsSelectionIndicator = NO;
		[self addSubview:internalPickerView];
		
		allOption = false;
		allSelected = false;
	}
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[allOptionTitle release];
	
	[internalPickerView release];
	[super dealloc];
}

- (void)setNeedsLayout {
	[super setNeedsLayout];
	[internalPickerView setNeedsLayout];
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
	return [self.delegate numberOfRowsForPickerView:self] + (allOption ? 1 : 0);
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
	
	if (checkView == nil) {
		checkView = [[[CheckView alloc] init] autorelease];
	}
	else {
		checkView.delegate = nil;
	}
	
	if (allOption && row == 0) {
		checkView.title = (allOptionTitle != nil) ? allOptionTitle : @"All";
		checkView.selected = allSelected;
		checkView.tag = -1;
	}
	else {
		int actualRow = row - (allOption ? 1 : 0);
		
		checkView.title = [delegate pickerView:self textForRow:actualRow];
		checkView.selected = [delegate pickerView:self selectionStateForRow:actualRow];
		checkView.tag = actualRow;
	}
	
	[checkView setNeedsDisplay];
	checkView.delegate = self;
	
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
		
		if (checkView.tag == -1) {
			// Select all rows
			allSelected = selected;
			[self setNeedsLayout];
		}
		else if (allSelected == YES) {
			allSelected = NO;
			[self setNeedsLayout];
		}
		else if(allSelected == NO) {
			// Check if all rows are checked
			for (int i = 0; i < [self.delegate numberOfRowsForPickerView:self]; i++) {
				if ([delegate pickerView:self selectionStateForRow:i] == NO)
					return;
			}
			allSelected = YES;
			[self setNeedsLayout];
		}
	}
}

@end
