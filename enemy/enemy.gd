extends CharacterBody2D

@export var health  : int = 1 
@export var movement_speed : int = 2000
@export var attack_damage : int = 1
@export var attack_speed : float = 1
var cooldown : float = attack_speed
var is_player_in_range = false
@onready var navigation_agent = $navigation_agent

func take_damage (damage_taken):
	if damage_taken > 0:
		health -= damage_taken
		$Node2D.update_bar()
		if health <= 0:
			die()
	else: 
		print("fehler in klasse enemy methode take_damage damage_taken ist positiv oder 0")
	print(health)

func die ():
	#loot übergben
	$CollisionShape2D2.disabled = true
	$AnimatedSprite2D.play("die")
	await get_tree().create_tween().tween_interval(1).finished
	GameManager.on_enemy_died(self.global_position)
	self.queue_free() 

func move_towards_player (delta):
	navigation_agent.set_target_position(PLAYER_CHARACTER.global_position)
	if navigation_agent.is_target_reachable() == true:
		var direktion = (navigation_agent.get_next_path_position()-self.position).normalized()
		self.velocity = direktion * movement_speed * delta
	if self.velocity.x > 0:
		get_node("AnimatedSprite2D").flip_h = true
	else:
		get_node("AnimatedSprite2D").flip_h = false
	move_and_slide()

func attak (damage_to_deal):
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("attac")
	print("hit")
	PLAYER_CHARACTER.take_damage(damage_to_deal)
	await get_tree().create_tween().tween_interval(1).finished
	$AnimatedSprite2D.play("walk")

func heal (healing):
	if healing > 0:
		health += healing
	else:
		print ("healing ist negativ klasse enemy funktion heal")

func _process(delta):
	if health > 0:
		move_towards_player(delta)
		if cooldown > 0:
			cooldown -= delta
		elif cooldown < 0 and is_player_in_range == true:
			cooldown = attack_speed
			attak(attack_damage)

func _ready():
	self.add_to_group("enemy")
	#$AnimatedSprite2D.play("spawn")
	$AnimatedSprite2D.play("walk")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		is_player_in_range = true

func _on_area_2d_body_exited(body):
	is_player_in_range = false

#func _on_navigation_agent_velocity_computed(safe_velocity):
	#direktion = safe_velocity
