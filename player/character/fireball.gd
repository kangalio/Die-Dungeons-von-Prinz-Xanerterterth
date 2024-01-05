extends "res://player/character/bullet.gd"

var explosion = load("res://player/character/explosion.tscn")

func _ready():
	time = 100000
	direction.normalized()
	$AnimatedSprite2D.play()

func _on_area_2d_body_entered(body):
	if not body.is_in_group("player"):
		var explosion_instance = explosion.instantiate()
		queue_free()
		self.add_sibling(explosion_instance)
		explosion_instance.position = self.position
