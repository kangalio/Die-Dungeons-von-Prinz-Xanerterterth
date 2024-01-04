extends Area2D

var damage : int = 10
var cooldown : float = 1
var cooldown_static : float = cooldown

func attack(bonus_damage):
	if cooldown <= 0:
		cooldown = cooldown_static
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("enemy"):
				body.take_damage(damage+bonus_damage)
				

func _process(delta):
	if cooldown > 0:
		cooldown -= delta
