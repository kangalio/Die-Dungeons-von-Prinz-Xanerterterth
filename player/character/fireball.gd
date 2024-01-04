extends "res://player/character/bullet.gd"

var explosion = load("res://player/character/explosion.tscn")

func _ready():
	direction.normalized()
	$AnimatedSprite2D.play("default")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") :
		print("spawn")
	else:
		var explosion_instance = explosion.instantiate()
		explosion_instance.bonus_damage = bonus_damage
		self.add_sibling(explosion_instance)
		explosion_instance.position = self.position 
		queue_free()
