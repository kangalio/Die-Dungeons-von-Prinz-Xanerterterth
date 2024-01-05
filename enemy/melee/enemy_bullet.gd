extends CharacterBody2D

@export var damage : int = 1
@export var bullet_speed : int = 50
var direction = Vector2(1, 0)

func _ready():
	pass
	direction = direction.normalized()

func _process(delta):
	self.velocity = direction * bullet_speed * delta * 290
	self.rotation_degrees = rad_to_deg(velocity.angle())
	move_and_slide()
	print(direction)

func _on_area_2d_body_entered(body):
	if body == PLAYER_CHARACTER:
		body.take_damage(damage)
		$Venom.frame = 1
		await get_tree().create_timer(0.2).timeout
		queue_free()
	elif not body.is_in_group("enemy"):
		$Venom.frame = 1
		await get_tree().create_timer(0.3).timeout
		queue_free()
