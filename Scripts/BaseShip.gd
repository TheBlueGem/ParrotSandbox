extends KinematicBody2D

var movement = Vector2(0, 0)
var turnDirection = 0
var speed = 0.0
var currentDirection = 0.0
var turnSpeed = 0

func _ready():
	self.set_process(true)	
	turnDirection = atan2(movement.x, movement.y)
	
func _process(delta):
	if(Input.is_key_pressed(KEY_UP)):
		if(speed < 10):
			accelerate(1.01)
	if(Input.is_key_pressed(KEY_DOWN)):
		accelerate(0.9)
		print(movement)
	if(Input.is_key_pressed(KEY_RIGHT)):
		if(turnSpeed > -3):
		#turn(deg2rad(1)		
			turnSpeed -= .1
			
	if(Input.is_key_pressed(KEY_LEFT)):
		if(turnSpeed < 3):
			turnSpeed += .1
		#turn(deg2rad(-1)	
		
	if(turnSpeed != 0):
		if(turnDirection > currentDirection):
			turn(deg2rad(turnSpeed))
			self.set_rot(currentDirection + deg2rad(turnSpeed))
			turnSpeed -= .1
			
		if(turnDirection < currentDirection):
			turn(deg2rad(turnSpeed))
			self.set_rot(currentDirection + deg2rad(turnSpeed))
			turnSpeed += .1
		#turn(deg2rad(turnSpeed))
	#turn - 1 * delta		
	
	speed = movement.length()	
	self.move(movement);
	
	var cur_pos = self.get_pos()

	if(cur_pos.x > self.get_viewport_rect().size.width + self.get_item_rect().size.width/2):
      cur_pos.x = -self.get_item_rect().size.width/2
	if(cur_pos.x + self.get_item_rect().size.width*4 <= 0):
		cur_pos.x = self.get_viewport_rect().size.width - self.get_item_rect().size.width/2
	if(cur_pos.y > self.get_viewport_rect().size.height + self.get_item_rect().size.height/2):
      cur_pos.y = -self.get_item_rect().size.height/2
	if(cur_pos.y + self.get_item_rect().size.height*4 <= 0):
		cur_pos.y = self.get_viewport_rect().size.height - self.get_item_rect().size.height

	self.set_pos(cur_pos)
	
func accelerate(factor):	 
	currentDirection = atan2(movement.x, movement.y)
	var cosAngle = cos(currentDirection)
	var sinAngle = sin(currentDirection)
	
	var x = movement.length() * factor
	var y = movement.length() * factor
	
	
	if(movement.length() > 0.15):
		movement.x = (x) * sinAngle
		movement.y = (y) * cosAngle
	else:
		if(factor < 1):			
			movement.x = 0.0
			movement.y = 0.0
		else:
			movement.x = cosAngle * 2
			movement.y = sinAngle * 2
		
func turn(degrees):
	currentDirection = atan2(movement.x, movement.y) + degrees
	var cosAngle = cos(currentDirection)
	var sinAngle = sin(currentDirection)
	movement.x = sinAngle * movement.length()
	movement.y = cosAngle * movement.length()
