extends "res://player/upgrade/upgrade.gd"

var is_weapon : bool = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	 # Replace with function body.

func attack():
		var bullet = bullet_scene.instantiate()
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
