extends Area2D

var damage : int = 2
var cooldown : float = 2
var cooldown_static : float = cooldown

func attack():
	if cooldown <= 0:
		cooldown = cooldown_static
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("enemy"):
				body.take_damage(damage)

func _process(delta):
	self.position = PLAYER_CHARACTER.position
	if cooldown > 0:
		cooldown -= delta # => cooldwon von cooldown in sekunden
