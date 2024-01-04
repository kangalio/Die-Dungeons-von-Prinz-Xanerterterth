extends "res://player/upgrade/upgrade.gd"

var is_weapon : bool = true 
var bullet_scene = preload("res://player/character/bullet.tscn")
var bullet_speed = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	PLAYER_CHARACTER.weapon_damage = 2
	pass
	 # Replace with function body.

func attack(damage):
		var bullet = bullet_scene.instantiate()
		bullet.damage = damage
		bullet.position = PLAYER_CHARACTER.position
		bullet.direction = PLAYER_CHARACTER.player_direction
		PLAYER_CHARACTER.add_sibling(bullet)
		_do_recoil(1)

func _do_recoil(strength):
	pass
	#den Player zurücksetzen und dan wieder vor ( nicht wichtig aber schön)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
