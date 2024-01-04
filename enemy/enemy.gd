extends CharacterBody2D

var health  : int = 1 
var movement_speed : int = 5
var attack_damage : int = 1
var attack_speed : int 
@onready var navigation_agent = $navigation_agent

func take_damage (damage_taken):
	if damage_taken > 0:
		health -= damage_taken
		if health <= 0:
			die()
	else: 
		print("fehler in klasse enemy methode take_damage damage_taken ist positiv oder 0")

func die ():
	#loot übergben
	$AnimatedSprite2D.play("die")
	self.queue_free() 

func move_towards_player (delta):
	navigation_agent.set_target_position(PLAYER_CHARACTER.global_position)
	if navigation_agent.is_target_reachable() == true:
		var direktion = (navigation_agent.get_next_path_position()-self.position).normalized()
		self.position += direktion
		$AnimatedSprite2D.play("walk")
		move_and_slide()

	
func attak (damage_to_deal):
	PLAYER_CHARACTER.take_damage(damage_to_deal)
	
func heal (healing):
	if healing > 0:
		health += healing
	else:
		print ("healing ist negativ klasse enemy funktion heal")
		

func _process(delta):
	move_towards_player(delta)
	$AnimatedSprite2D.play("walk")

func _ready():
	self.add_to_group("enemy")
	$AnimatedSprite2D.play("spawn")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		attak(attack_damage)
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("attac")
		print("hit")
