extends Node2D

var exists : bool = true

var max_health : int

func _ready():
	max_health = get_parent().health
	$Bar.frame = 5
	
func update_bar():
	if get_parent().health > 0:
		var health = 100 / float(max_health / get_parent().health)
		self.scale.x =  float(get_parent().health) / float(max_health)
		if health < 17:
			$Bar.frame = 0
		elif health < 33:
			$Bar.frame = 1
		elif health < 50:
			$Bar.frame = 2
		elif health < 66:
			$Bar.frame = 3
		elif health < 83:
			$Bar.frame = 4
		elif health < 99:
			$Bar.frame = 5
	elif exists == true:
		exists = false
		$Bar.queue_free()
