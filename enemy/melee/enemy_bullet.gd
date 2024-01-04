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
	if body == PLAYER_CHARACTER:
		body.take_damage(damage)
		queue_free()
