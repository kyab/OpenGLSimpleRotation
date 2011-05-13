//
//  RotationView.mm
//  OpenGLSimpleRotation
//
//  Created by koji on 11/03/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RotationView.h"
#import "NSColor_extention.h"

GLfloat m[16];
GLfloat lookY;
void
drawGLString(GLfloat x, GLfloat y, GLfloat z, const char *string)
{
	int len, i;
	
	glRasterPos3f(x, y, z);
	len = (int) strlen(string);
	for (i = 0; i < len; i++) {
		glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, string[i]);
	}
}


@implementation RotationView
@synthesize mesh = _mesh;

- (id)initWithFrame:(NSRect)frame {
	NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.

    }
    return self;
}

-(void)awakeFromNib{
	//here we cant use OpenGL;
	NSLog(@"awake From nib(OpenGL)");
	_mouseDragging = false;
	_mesh = false;
}


-(void)addRotateZ:(float) angle{
	[self rotate:angle forX:0.0 forY:0.0 forZ:1.0];
}
-(void)addRotateX:(float) angle{
	[self rotate:angle forX:1.0 forY:0.0 forZ:0.0];
}
-(void)addRotateY:(float) angle{
	[self rotate:angle forX:0.0 forY:1.0 forZ:0.0];
}

-(void)testFunc:(float)value{
	NSLog(@"value = %f", value);
}
-(void)rotate:(float)angle forX:(float)x forY:(float)y forZ:(float)z{
		
	//create new rotation matrix, then multyply it to m
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glLoadIdentity();
	
	glRotatef(angle, x, y, z);
	glMultMatrixf(m);
	
	glGetFloatv(GL_MODELVIEW, m);
	glPopMatrix();

	NSLog(@"rotation added. angle = %f, x = %f ,y = %f ,z = %f", angle, x, y, z);
	[self setNeedsDisplay:YES];
}

-(void)addShiftX:(float)x{
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glLoadIdentity();
	
	glTranslated(x,0.0,0.0);
	glMultMatrixf(m);
	glGetFloatv(GL_MODELVIEW, m);
	glPopMatrix();
	
	[self setNeedsDisplay:YES];
}

//リサイズに対応
- (void)reshape{
	//NSLog(@"reshape");
	NSRect bounds = [self bounds];
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	//このビューの全面に描画。
	glViewport(
			   (int)bounds.origin.x, (int)bounds.origin.y,
			   (int)bounds.size.width, (int)bounds.size.height);
	

	glOrtho(-1.0, 1.0, -1.0, 1.0, -10000.0, 10000.0);
	glMatrixMode(GL_MODELVIEW);
	
}
- (void)prepareOpenGL{
	NSLog(@"prepareOpenGL called");
	
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	glLoadIdentity();

	glGetFloatv(GL_MODELVIEW, m);
	
	glPopMatrix();
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	
	//素の状態で見るときは以下を外す。。
	//gluLookAt(10,10,10,0,0,0,0,1,0);	
	
	
	
}

- (void)setupLight{
	//ライトは絶対座標系において、同じ位置に固定する。
	//GL_PROJECTIONで指定してやればOK？

}

- (void)drawCube{
	static const float LINE_WIDTH = 0.7f;
	float	halfLen = LINE_WIDTH/2;

	
	[[NSColor greenColor] openGLColor4f];
	glBegin(GL_QUADS);{
		glVertex3f(-halfLen, -halfLen, halfLen);
		glVertex3f( halfLen, -halfLen, halfLen);
		glVertex3f( halfLen, halfLen, halfLen);
		glVertex3f( -halfLen, halfLen, halfLen);
	}glEnd();
	
	[[NSColor whiteColor] openGLColor4f];
	glBegin(GL_QUADS);{
		glVertex3f(-halfLen, -halfLen, -halfLen);
		glVertex3f( halfLen, -halfLen, -halfLen);
		glVertex3f( halfLen, halfLen, -halfLen);
		glVertex3f( -halfLen, halfLen, -halfLen);
	}glEnd();
	
	[[NSColor cyanColor] openGLColor4f];
	glBegin(GL_QUADS);{
		glVertex3f(-halfLen, -halfLen, -halfLen);
		glVertex3f(-halfLen, -halfLen, halfLen);
		glVertex3f(-halfLen, halfLen, halfLen);
		glVertex3f(-halfLen, halfLen, -halfLen);
	}glEnd();
	
	[[NSColor orangeColor] openGLColor4f];
	glBegin(GL_QUADS);{
		glVertex3f(halfLen, -halfLen, -halfLen);
		glVertex3f(halfLen, -halfLen, halfLen);
		glVertex3f(halfLen, halfLen, halfLen);
		glVertex3f(halfLen, halfLen, -halfLen);
	}glEnd();
	
	[[NSColor brownColor] openGLColor4f];
	glBegin(GL_QUADS);{
		glVertex3f( -halfLen, -halfLen, halfLen);
		glVertex3f( halfLen, -halfLen, halfLen);
		glVertex3f( halfLen, -halfLen, -halfLen);
		glVertex3f(-halfLen, -halfLen, -halfLen);
	}glEnd();
	
	[[NSColor grayColor] openGLColor4f];
	glBegin(GL_QUADS);{
		glVertex3f( -halfLen, halfLen, halfLen);
		glVertex3f( halfLen, halfLen, halfLen);
		glVertex3f( halfLen, halfLen, -halfLen);
		glVertex3f(-halfLen, halfLen, -halfLen);
	}glEnd();
	
	glDisable(GL_LIGHTING);
	[[NSColor blueColor] openGLColor4f];
	glBegin(GL_LINE_LOOP);{
		glVertex3f(-halfLen, -halfLen, halfLen);
		glVertex3f( halfLen, -halfLen, halfLen);
		glVertex3f( halfLen, halfLen, halfLen);
		glVertex3f( -halfLen, halfLen, halfLen);
	}glEnd();	
	
	glBegin(GL_LINE_LOOP);{
		glVertex3f( -halfLen, -halfLen, -halfLen);
		glVertex3f( halfLen, -halfLen, -halfLen);
		glVertex3f( halfLen, halfLen, -halfLen);
		glVertex3f( -halfLen, halfLen, -halfLen);	
	}glEnd();
	
	
	glBegin(GL_LINES);{
		glVertex3f(-halfLen, -halfLen, halfLen);
		glVertex3f( -halfLen, -halfLen, -halfLen);
		
		glVertex3f(-halfLen, halfLen, halfLen);
		glVertex3f( -halfLen, halfLen, -halfLen);
		
		glVertex3f( halfLen, halfLen, halfLen);
		glVertex3f( halfLen, halfLen, -halfLen);
		
		glVertex3f( halfLen, -halfLen, halfLen);
		glVertex3f( halfLen, -halfLen, -halfLen);
		
	}glEnd();
}
	
- (void)drawAxis{

	glBegin(GL_LINES);{
		//x axis
		glVertex3f(-1.0, 0, 0);
		glVertex3f( 1.0, 0, 0);

		//y axis
		glVertex3f( 0,-1.0, 0);
		glVertex3f( 0, 1.0, 0);
		
		//z axis
		glVertex3f( 0, 0,-1.0);
		glVertex3f( 0, 0, 1.0);
	}glEnd();
	
	drawGLString(1.0, 0 ,0 , "x");
	drawGLString(0, 1.0, 0,  "y");
	drawGLString(0, 0, 1.0, "z");

	
}


- (void)drawRect:(NSRect)dirtyRect {

	[[NSColor blackColor] openGLClearColor];
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	

	glEnable(GL_DEPTH_TEST);	//隠面消去
	glMatrixMode(GL_MODELVIEW);

	if (_mesh){
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	}else{
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	}
	
	glPushMatrix();{
		glMultMatrixf(m);
		
		[self drawCube];
		
		glutSolidTeapot(0.2);
		
		[[NSColor blueColor] openGLColor4f];
		[self drawAxis];
	}glPopMatrix();
	
	{
		[[NSColor whiteColor] openGLColor4f];
		[self drawAxis];
	}
	glDisable(GL_DEPTH_TEST);
	
	glFinish();
	glFlush();
	NSLog(@"drawRect");
	
}

#pragma mark ---- Mouse Handlings ----

- (NSPoint)pointFromEvent:(NSEvent *)theEvent{
	return [self convertPoint:[theEvent locationInWindow] fromView:nil];
}

- (void)mouseDown:(NSEvent *)theEvent{
	NSLog(@"mouse down. click count = %ld", [theEvent clickCount]);
	_mouseDragging = true;
	_prevDragPoint = [self pointFromEvent:theEvent];
}

- (void)mouseUp:(NSEvent *)theEvent{
	NSLog(@"mouse up");
	_mouseDragging = false;
}


/*needs setAcceptsMouseMovedEvents for window, to receive this event*/
- (void)mouseMoved:(NSEvent *)theEvent{
	//needs setAcceptsMouseMovedEvents:
	NSLog(@"mouse moved");
}


- (void)mouseDragged:(NSEvent *)theEvent{
	NSPoint curPoint = [self pointFromEvent:theEvent];
	
	if (_mouseDragging == false) return;

	float distanceX = curPoint.x -  _prevDragPoint.x;
	float distanceY = curPoint.y -  _prevDragPoint.y;
	float angleX = distanceX / self.bounds.size.width * 180;
	float angleY = distanceY / self.bounds.size.height * 180;
	
	//NSLog(@"drag(%f,%f) distance = %f", curPoint.x, curPoint.y, distanceX);
	[self addRotateY:angleX];
	[self addRotateX:-angleY];
	//[self rotate:3.0f forX:-angleY forY:angleX forZ:0];
	_prevDragPoint = curPoint;
	
}

- (void)rightMouseDown:(NSEvent *)theEvent{
	NSLog(@"right mouse down. click count = %ld", [theEvent clickCount]);
	_mouseDragging = true;
	_prevDragPoint = [self pointFromEvent:theEvent];
}

- (void)rightMouseDragged:(NSEvent *)theEvent
{
	NSPoint curPoint = [self pointFromEvent:theEvent];
	
	if (_mouseDragging == false) return;
	
	float distanceX = curPoint.x -  _prevDragPoint.x;
	float angleX = distanceX / self.bounds.size.width * 180;
	
	[self addRotateZ:angleX];
	distanceX /= self.bounds.size.width;
	//[self addShiftX:distanceX];
	_prevDragPoint = curPoint;
}

-(void)rightMouseUp:(NSEvent *)theEvent{
	_mouseDragging = false;
}

- (void)otherMouseDragged:(NSEvent *)theEvent
{
	NSLog(@"other");
	//[self mouseDragged: theEvent];
}

-(void)setMesh:(Boolean)mesh{
	_mesh = mesh;
	[self setNeedsDisplay:YES];
}

@end
