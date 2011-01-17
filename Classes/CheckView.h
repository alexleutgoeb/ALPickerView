//
//  CheckView.h
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

#import <UIKit/UIKit.h>

@class CustomTapGestureRecognizer;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@interface CheckView : UIView {
	NSString *title;
	UIImage *checkImage;
	
	CustomTapGestureRecognizer *gestureRec;
	
	BOOL selected;
	UIColor *grayBlueColor;
	UIColor *labelColor;
}

// The title of the row view
@property (nonatomic, retain) NSString *title;
// The selection state of the row view
@property (assign) BOOL selected;

// Return view's width
+ (CGFloat)viewWidth;
// Return view's height
+ (CGFloat)viewHeight;

@end
