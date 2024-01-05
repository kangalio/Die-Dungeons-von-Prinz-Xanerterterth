extends Area2D



var damage : int = 5
var cooldown : float = 0
var cooldown_static : float = 0.5
var is_weapon = true 
var sword_is_rotation : bool = false

func attack(bonus_damage):
	if cooldown <= 0:
		cooldown = cooldown_static
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("enemy"):
				body.take_damage(damage+bonus_damage)
		sword_is_rotation = true

var rotation_speed = 30

func _process(delta):
	if cooldown > 0:
		cooldown -= delta # => cooldwon von cooldown in sekunden

	if sword_is_rotation:
		if $Node2D.rotation < 2*PI:
			print($Node2D.rotation)
			$Node2D.rotation = $Node2D.rotation + (rotation_speed*delta)
		else:
			print('sword stopped')
			$Node2D.rotation = 0
			sword_is_rotation = false
