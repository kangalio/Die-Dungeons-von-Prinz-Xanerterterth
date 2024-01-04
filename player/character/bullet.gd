extends CharacterBody2D

@export var damage : int = 1
@export var bullet_speed : int = 10000
var direction = Vector2(1, 0)

func _ready():
	direction.normalized()

func _process(delta):
	self.velocity = direction * bullet_speed * delta
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		queue_free()
	elif body.is_in_group("wall"):
		queue_free()
