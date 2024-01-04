extends CharacterBody2D

@export var damage : int = 3
@export var bullet_speed : int = 10000
var direction = Vector2(1, 0)
var bonus_damage = 0
var time = 2

func _ready():
	direction.normalized()

func _process(delta):
#	$AnimatedSprite2D.play("default")
	time -= delta 
	if time <= 0:
		queue_free()
	self.velocity = direction * bullet_speed * delta
	move_and_slide()

func _on_area_2d_body_entered(body):
	print("hfds")
	if body.is_in_group("player") == false:
		print("!")
		if body.is_in_group("enemy"):
			body.take_damage(damage + bonus_damage)
			queue_free()
		else:
			queue_free()
	
