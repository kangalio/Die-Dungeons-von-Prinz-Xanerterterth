extends "res://player/upgrade/upgrade.gd"

var is_weapon : bool = true 
var bullet_scene = preload("res://player/character/bullet.tscn")
var bullet_speed = 10

func attack(bonus_damage):
		var bullet = bullet_scene.instantiate()
		bullet.bonus_damage = bonus_damage
		bullet.position = PLAYER_CHARACTER.position
		bullet.direction = PLAYER_CHARACTER.player_direction
		PLAYER_CHARACTER.add_sibling(bullet)

func _process(delta):
	pass
