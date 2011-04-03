# Controller.rb
# OpenGLSimpleRotation
#
# Created by koji on 11/03/09.
# Copyright 2011 __MyCompanyName__. All rights reserved.

class ControllerBase < NSObject
	def awakeFromNib
		puts "#{self.class} awaked from nib"
	end
end

class Controller < ControllerBase
	attr_accessor :view
	
	def applicationShouldTerminateAfterLastWindowClosed(sender)
		true
	end
	
	def rotateZ(sender)
		@view.addRotateZ(5);
	end
	def rotateY(sender)
		@view.addRotateY(5);
	end
	def rotateX(sender)
		@view.addRotateX(5);
	end
end
