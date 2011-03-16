//
//  DemoViewController.h
//  Demo
//
//  Created by Alex Leutgöb on 17.01.11.
//  Copyright 2011 alexleutgoeb.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALPickerView.h"


@interface DemoViewController : UIViewController <ALPickerViewDelegate> {
	NSArray *entries;
	NSMutableDictionary *selectionStates;
	
	ALPickerView *pickerView;
}

@end
