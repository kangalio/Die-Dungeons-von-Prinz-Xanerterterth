extends "res://player/character/bullet.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
