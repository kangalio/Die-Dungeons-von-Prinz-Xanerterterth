extends "res://player/upgrade/upgrade.gd"

var is_weapon : bool = false

func _ready():
	print("jetzt kanst du länger leiden")
	PLAYER_CHARACTER.running_LP += 1000000000000
	PLAYER_CHARACTER.bonus_damage += 1000000000000

func _process(delta):
	pass
