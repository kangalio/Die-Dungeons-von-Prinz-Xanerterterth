extends Node2D

var fireball_scene = preload("res://player/character/fireball.tscn")
var cooldown : int = 10
var cooldown_static : int = cooldown 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func attack():
	if cooldown <= 0:
		cooldown = cooldown_static
		var fireball = fireball_scene.instantiate()
		PLAYER_CHARACTER.add_sibling(fireball_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown > 0:
		cooldown -= delta
