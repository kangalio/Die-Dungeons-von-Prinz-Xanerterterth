extends "res://player/upgrade/upgrade.gd"


var is_weapon : bool = false

func _ready():
	print("jetzt kanst du mehr schmertzen verursachen")
	PLAYER_CHARACTER.bonus_damage += 3

func _process(delta):
	pass
