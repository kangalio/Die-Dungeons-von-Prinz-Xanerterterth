extends CharacterBody2D

@export var damage : int = 1
@export var bullet_speed : int = 80
var direction = Vector2(1, 0)

func _ready():
	direction.normalized()

func _process(delta):
	self.velocity = direction * bullet_speed * delta
	self.rotation_degrees = rad_to_deg(velocity.angle())
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body == PLAYER_CHARACTER:
		body.take_damage(damage)
		queue_free()
