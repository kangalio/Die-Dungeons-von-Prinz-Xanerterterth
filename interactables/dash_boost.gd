extends "res://player/upgrade/upgrade.gd"


var is_weapon : bool = false

func _ready():
	print("dash is upgraded")
	if PLAYER_CHARACTER.dash_charging_threshold_timer - 0.2 >= 0:
		PLAYER_CHARACTER.dash_charging_threshold_timer -= 0.2 
	if PLAYER_CHARACTER.dash_cooldown_threshold - 0.5 >= 0:
		PLAYER_CHARACTER.dash_cooldown_threshold -0.5  
	PLAYER_CHARACTER.dash_duration_threshold += 0.1
	# code

func _process(delta):
	pass
