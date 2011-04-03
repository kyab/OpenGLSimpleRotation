//
//  RotationView.h
//  OpenGLSimpleRotation
//
//  Created by koji on 11/03/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface RotationView : NSOpenGLView {
	bool _mouseDragging;
	NSPoint _prevDragPoint;

}
-(void)rotate:(float)angle forX:(float)x forY:(float)y forZ:(float)z;
@end
