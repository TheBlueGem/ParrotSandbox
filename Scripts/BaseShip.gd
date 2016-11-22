extends KinematicBody2D

var movement = Vector2(0, 0)
var turnDirection = 0
var speed = 0.0
var currentDirection = deg2rad(180)
var turnSpeed = 0
var maxTurn = 2
var counter = 0

func _ready():
	self.set_process(true)		
	turnDirection = atan2(movement.x, movement.y)
	setCannons(8);
	
func _process(delta):
	counter += 10 * delta
		
	if(counter >= 5):
		counter = 0
		print("turnDirection:", turnDirection)
		print("movement: ", movement)
		print("currentDirection: ", currentDirection)
		print("turnSpeed: ", turnSpeed)
		print("speed: ", speed)
			
	var accelerating = Input.is_action_pressed("accelerate")
	var decelerating = Input.is_action_pressed("decelerate")
	var rudder_left = Input.is_action_pressed("rudder_left")
	var rudder_right = Input.is_action_pressed("rudder_right")
	
	if(accelerating and not decelerating):
		if(speed < 10):
			accelerate(1.01)			
	if(decelerating and not accelerating and speed != 0):
		if(speed > 0.1):			
			accelerate(0.9)		
		else:
			setSpeed(0)
			
	if(rudder_left and not rudder_right):
		if(turnSpeed < maxTurn):
			turnSpeed += .15			
	if(rudder_right and not rudder_left):
		if(turnSpeed > -maxTurn):
			turnSpeed -= .15
			
		
	if(turnSpeed != 0):
		turn(deg2rad(turnSpeed))
		self.set_rot(currentDirection + deg2rad(turnSpeed))
		
		if(turnSpeed > 0):
			turnSpeed -= .05
			
		if(turnSpeed < 0):
			turnSpeed += .05

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
			movement.x = cosAngle * 0.0001
			movement.y = sinAngle * 0.0001
		else:
			movement.x = cosAngle * 2
			movement.y = sinAngle * 2
		
func turn(degrees):
	currentDirection = atan2(movement.x, movement.y) + degrees
	var cosAngle = cos(currentDirection)
	var sinAngle = sin(currentDirection)
	movement.x = sinAngle * movement.length()
	movement.y = cosAngle * movement.length()
	
func setSpeed(speed):
	currentDirection = atan2(movement.x, movement.y)
	var cosAngle = cos(currentDirection)
	var sinAngle = sin(currentDirection)
	movement.x = sinAngle * 0.0001
	movement.y = sinAngle * 0.0001
	
func setupCannons(amount):
	for i in range (0, amount):
		