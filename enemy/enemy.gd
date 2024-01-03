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
		print("take_damage")
	else: 
		print("fehler in klasse enemy methode take_damage damage_taken ist positiv oder 0")

func die ():
	print("die")
	#loot übergben
	self.queue_free() 

func move_towards_player ():
	navigation_agent.set_target_position(PLAYER_CHARACTER.global_position)
	print ("move towards player")
	
func attak (damage_to_deal):
	print("attack")
	
func heal (healing):
	if healing > 0:
		health += healing
	else:
		print ("healing ist negativ klasse enemy funktion heal")
func _ready():
	move_towards_player()

func _process(delta):
	if navigation_agent.is_target_reachable() == true:
		navigation_agent.set_velocity((navigation_agent.get_next_path_position()-self.position).normalized()) * movement_speed * delta
		move_and_slide()
	pass
