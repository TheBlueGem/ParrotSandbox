extends Node2D

func _ready():
	set_process(true)
	
func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		self.get_tree().quit()
