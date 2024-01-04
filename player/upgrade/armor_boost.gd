extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	PLAYER_CHARACTER.armor += 1
	print('make me harder')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
