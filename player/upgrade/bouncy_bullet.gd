extends CharacterBody2D

@export var damage : int = 7
@export var bullet_speed : int = 20000
var direction = Vector2(1, 0)
var bonus_damage = 0
var time = 50000

func _ready():
	direction.normalized()
	$AnimatedSprite2D.play()

#func _on_Bullet_body_entered(body):
	#if body.is_in_group("player") == false:
		#if body.is_in_group("enemy"):
			#body.take_damage(damage + bonus_damage)
			#queue_free()

func _physics_process(delta):
	time -= delta 
	if time <= 0:
		queue_free()
	self.velocity = direction * bullet_speed * delta
	var collision = move_and_collide(velocity*delta)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group('enemy'):
			print('collided with enemy')
			collider.take_damage(damage + bonus_damage)
			queue_free()
		else:
			direction = velocity.bounce(collision.get_normal()).normalized()
