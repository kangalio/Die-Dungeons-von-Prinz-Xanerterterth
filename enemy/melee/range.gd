extends "res://enemy/enemy.gd"

func attak (damage_to_deal):
	$AnimatedSprite2D.play("attac")
	print("hit")
	await get_tree().create_tween().tween_interval(1).finished
	$AnimatedSprite2D.play("walk")
	var enemy_bullet = preload("res://enemy/melee/enemy_bullet.tscn").instantiate()
	enemy_bullet.position = self.position
	enemy_bullet.direction = PLAYER_CHARACTER.global_position - self.global_position
	self.add_sibling(enemy_bullet)
