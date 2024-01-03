extends Node

var bullet_scene = preload("res://player/character/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func do_bullet_input():
		var bullet = bullet_scene.instantiate()
		bullet.position = self.position
		bullet.velocity = PLAYER_CHARACTER.Vector2.from_angle(facing_direction) * 15
		add_sibling(bullet)
		_do_recoil(1)

func _do_recoil(strength):
	pass
	#den Player zurücksetzen und dan wieder vor ( nicht wichtig aber schön)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
