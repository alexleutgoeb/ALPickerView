//
//  ALPickerViewCell.m
//
//  Created by Alex Leutgöb on 11.11.11.
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
  self.textLabel.frame = CGRectMake(44, 9, self.frame.size.width - 54, 24);
}

@end
