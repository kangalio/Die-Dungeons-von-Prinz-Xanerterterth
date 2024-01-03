extends CharacterBody2D

var health : int 
var movement_speed : int
var attack_damage : int 
var attack_speed : int 

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
func move_towards_player (speed, delta_enemy):
	# man braucht einen deltawert, da sich der enemy in dieser funktion bewegt
	var player_position = get_node("player").position
	var direction = (player_position - position).normalized()
	var velocity = direction * speed
	move_and_collide(velocity * delta_enemy)
	# ich habe hier collide und nicht slide verwendet, denn der enemy soll mit
	# der bewegung aufhören, wenn er den spieler berührt und die hit animation
	# abspielen
	print("move")
func attak (damage_to_deal):
	print("attack")
func heal (healing):
	if healing > 0:
		health += healing
	else:
		print ("healing ist negativ klasse enemy funktion heal")
