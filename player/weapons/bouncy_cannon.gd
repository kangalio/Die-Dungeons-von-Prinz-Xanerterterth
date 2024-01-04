extends Node2D

var bullet_scene = preload("res://player/weapons/bouncy_bullet.gd")
var cooldown : int = 100
var cooldown_static : int = cooldown 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func attack (bonus_damage):
	if cooldown <= 0:
		cooldown = cooldown_static
		var bullet = bullet_scene.instantiate()
		bullet.bonus_damage = bonus_damage
		PLAYER_CHARACTER.add_sibling(bullet)
		bullet.position = PLAYER_CHARACTER.position
		bullet.direction = PLAYER_CHARACTER.player_direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown > 0:
		cooldown -= delta
