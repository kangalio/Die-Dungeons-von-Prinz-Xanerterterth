extends Node2D

func _ready():
	pass
	#max_health = get_parent().health
	#print("max health at the bar at the beginning:" + str(max_health))
	
func update_bar():
	if get_parent().dash_charging_timer > 0:
		self.scale.x = float(get_parent().dash_charging_timer) / float(get_parent().dash_charging_threshold_timer)
		print("dash cahrging")
	elif get_parent().dash_cooldown > 0 :
		self.scale.x = float(get_parent().dash_cooldown) / float(get_parent().dash_cooldown_threshold)
		print("dash cooldown")
	else:
		self.scale.x = 0
	#print(self.scale.x)
