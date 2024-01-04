extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Debug: touched exit door ", self, self.get_parent(), self.get_parent().get_parent())
		self.get_parent().exit_room()
	pass # Replace with function body.
