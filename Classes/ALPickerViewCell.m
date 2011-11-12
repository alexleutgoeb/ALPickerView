//
//  ALPickerViewCell.m
//  PickerTest
//
//  Created by Alex Leutgöb on 12.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ALPickerViewCell.h"


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@implementation ALPickerViewCell

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
    selectionState_ = NO;
    self.textLabel.font = [UIFont boldSystemFontOfSize:21];
  }
  return self;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
  [super prepareForReuse];
  
  self.imageView.image = nil;
  self.imageView.highlightedImage = nil;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)selectionState {
  return selectionState_;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSelectionState:(BOOL)selectionState {
  selectionState_ = selectionState;
  
  if (selectionState_ != NO) {
    self.imageView.image = [UIImage imageNamed:@"check"];
    self.imageView.highlightedImage = [UIImage imageNamed:@"check_selected"];
    self.textLabel.textColor = [UIColor colorWithRed:33/256. green:80/256. blue:134/256. alpha:1];
  }
  else {
    self.imageView.image = nil;
    self.imageView.highlightedImage = nil;
    self.textLabel.textColor = [UIColor blackColor];
  }
  
  [self.imageView setNeedsDisplay];
  [self.textLabel setNeedsDisplay];
  [self setNeedsLayout];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
  [super layoutSubviews];
  
  self.imageView.frame = CGRectMake(15, 12, 18, 18);
  self.textLabel.frame = CGRectMake(44, 12, self.frame.size.width - 54, 18);
}

@end
