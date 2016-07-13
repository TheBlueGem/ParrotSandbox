
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true)
	pass
	
func _process(delta):
	var pos = self.get_pos()
	var rot = self.get_rot()
	
	if(Input.is_key_pressed(KEY_UP)):
		pos.y -= 10
		rot = 0
	if(Input.is_key_pressed(KEY_DOWN)):
		pos.y += 10
		rot = deg2rad(180)
	if(Input.is_key_pressed(KEY_RIGHT)):
		pos.x += 10
		rot = deg2rad(270)
	if(Input.is_key_pressed(KEY_LEFT)):
		pos.x -= 10
		rot = deg2rad(90)
		
	self.set_pos(pos)
	self.set_rot(rot)
