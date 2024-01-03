extends CharacterBody2D

var health : int 
var movement_speed : int
var attack_damage : int 
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
	self.queue_free() 

func move_towards_player (delta):
	movement_speed = 5
	navigation_agent.set_target_position(PLAYER_CHARACTER.global_position)
	if navigation_agent.is_target_reachable() == true:
		var direktion = (navigation_agent.get_next_path_position()-self.position).normalized()
		self.position += direktion
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

