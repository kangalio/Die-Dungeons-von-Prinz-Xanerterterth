extends Node2D

var is_weapon : bool = false 
var damage : int = 2
var rotation_speed : int = 1

func _ready():
	self.rotation = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.rotation < 2*PI:
			self.rotation = self.rotation + rotation_speed * 0.2
	else:
		self.rotation = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(damage)
	pass # Repace with function body.
