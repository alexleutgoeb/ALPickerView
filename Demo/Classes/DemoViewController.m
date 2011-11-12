//
//  DemoViewController.m
//  Demo
//
//  Created by Alex Leutgöb on 17.01.11.
//  Copyright 2011 alexleutgoeb.com. All rights reserved.
//

#import "DemoViewController.h"


@implementation DemoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Create some sample data
	entries = [[NSArray alloc] initWithObjects:@"Row 1", @"Row 2", @"Row 3", @"Row 4", @"Row 5", nil];
	selectionStates = [[NSMutableDictionary alloc] init];
	for (NSString *key in entries)
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	
	// Init picker and add it to view
	pickerView = [[ALPickerView alloc] initWithFrame:CGRectMake(0, 244, 0, 0)];
	pickerView.delegate = self;
	[self.view addSubview:pickerView];	
}

- (void)dealloc {
	[pickerView release];
	
	[selectionStates release];
	[entries release];
    [super dealloc];
}


#pragma mark -
#pragma mark ALPickerView delegate methods

- (NSInteger)numberOfRowsForPickerView:(ALPickerView *)pickerView {
	return [entries count];
}

- (NSString *)pickerView:(ALPickerView *)pickerView textForRow:(NSInteger)row {
	return [entries objectAtIndex:row];
}

- (BOOL)pickerView:(ALPickerView *)pickerView selectionStateForRow:(NSInteger)row {
	return [[selectionStates objectForKey:[entries objectAtIndex:row]] boolValue];
}

- (void)pickerView:(ALPickerView *)pickerView didCheckRow:(NSInteger)row {
	// Check whether all rows are checked or only one
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:YES] forKey:[entries objectAtIndex:row]];
}

- (void)pickerView:(ALPickerView *)pickerView didUncheckRow:(NSInteger)row {
	// Check whether all rows are unchecked or only one
	if (row == -1)
		for (id key in [selectionStates allKeys])
			[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:key];
	else
		[selectionStates setObject:[NSNumber numberWithBool:NO] forKey:[entries objectAtIndex:row]];
}

@end
