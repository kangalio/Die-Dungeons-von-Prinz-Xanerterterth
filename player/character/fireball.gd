extends "res://player/character/bullet.gd"

var explosion = load("res://player/character/explosion.tscn")

func _ready():
	direction.normalized()
	$AnimatedSprite2D.play()

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		var explosion_instance = explosion.instantiate()
		queue_free()
		self.add_sibling(explosion_instance)
	elif body.is_in_group("wall"):
		queue_free()
		var explosion_instance = explosion.instantiate()
		self.add_sibling(explosion_instance)
