extends "res://enemy/enemy.gd"

var attak_distance : int 

func move_towards_palyer (delta):
	navigation_agent.set_target_position(PLAYER_CHARACTER.global_position)
	if  navigation_agent.distance_to_target()<= attak_distance:
		super.move_towards_player(delta)
func _physics_process(delta):
	move_towards_palyer(delta)
