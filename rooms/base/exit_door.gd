extends Area2D

var touched_for_second_frame: int = 0
var touched_exit_door:int = 0
var frame: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame += 1
	if frame == 10:
		touched_for_second_frame = 1
	

func _on_body_entered(body):
	if body.is_in_group("player") and touched_for_second_frame:
		print("Debug: touched exit door ", self, self.get_parent(), self.get_parent().get_parent())
		self.get_parent().exit_room()
	pass # Replace with function body.
