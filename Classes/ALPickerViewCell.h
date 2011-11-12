//
//  ALPickerViewCell.h
//  PickerTest
//
//  Created by Alex Leutgöb on 12.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@interface ALPickerViewCell : UITableViewCell {
@private
  BOOL selectionState_;
}

@property (nonatomic, assign) BOOL selectionState;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
