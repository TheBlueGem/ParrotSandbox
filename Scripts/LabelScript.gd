
extends RichTextLabel

# member variables here, example:
# var a=2
# var b="textvar"

var count = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.add_text("Hello World")
	
	pass




func _on_Timer_timeout():
	count += 1
	self.clear()
	self.add_text(str("Hello World ", count))	
	pass # replace with function body
