extends "res://enemy/enemy.gd"

func attak (damage_to_deal):
	$AnimatedSprite2D.play("attac")
	await get_tree().create_tween().tween_interval(0.667).finished
	var enemy_bullet = preload("res://enemy/melee/enemy_bullet.tscn").instantiate()
	enemy_bullet.position = self.position
	enemy_bullet.direction = PLAYER_CHARACTER.global_position - self.global_position
	self.add_sibling(enemy_bullet)
	$AnimatedSprite2D.stop()

func _process(delta):
	if health > 0:
		if cooldown > 0:
			cooldown -= delta
		elif cooldown < 0:
			if is_player_in_range == true:
				cooldown = attack_speed
				attak(attack_damage)
			else:
				move_towards_player(delta)
				$AnimatedSprite2D.play("walk")
				
