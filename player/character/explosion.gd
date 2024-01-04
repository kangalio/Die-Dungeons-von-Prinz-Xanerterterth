extends Area2D

var damage : int = 5
var explosion_time : int = 10

func _process(delta):
	explosion_time -= delta
	$AnimatedSprite2D.play()
	if explosion_time <= 0:
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("enemy"):
				body.take_damage(damage)
		self.queue_free()
