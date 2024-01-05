extends Node2D

var max_health : int

func _ready():
	max_health = get_parent().health
	#print("max health at the bar at the beginning:" + str(max_health))
	
func update_bar():
	if get_parent().health > 0:
		self.scale.x =  float(get_parent().health) / float(max_health)
