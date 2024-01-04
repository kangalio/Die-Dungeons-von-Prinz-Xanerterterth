extends "res://player/upgrade/upgrade.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _heal():
	PLAYER_CHARACTER.LP += 10 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
