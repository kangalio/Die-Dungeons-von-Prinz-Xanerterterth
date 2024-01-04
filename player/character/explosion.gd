extends Area2D

var damage : int = 500000
var explosion_time : int = 10
var bonus_damage : int

func _ready():
	$AnimatedSprite2D.play("default")

func _process(delta):
	explosion_time -= delta
	if explosion_time <= 0:
		var bodies = self.get_overlapping_bodies()
		print (bodies)
		for body in bodies:
			if body.is_in_group("enemy"):
				body.take_damage(damage+bonus_damage)
		self.queue_free()
