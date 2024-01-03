extends Area2D

var velocity = Vector2(0, 0)

func _ready():
	pass # Replace with function body.

func _process(delta):
	self.position += self.velocity
