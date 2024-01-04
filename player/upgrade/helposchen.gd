extends "res://player/upgrade/upgrade.gd"


var is_weapon : bool = false

func _ready():
	print("jetzt kanst du länger leiden")
	PLAYER_CHARACTER.running_LP = PLAYER_CHARACTER.base_LP

func _process(delta):
	pass
