extends Area2D

var velocity = Vector2(0, 0)

func _ready():
	pass # Replace with function body.

func _process(delta):
	self.position += self.velocity

func _on_body_entered(body):
	print("!")
	if body.is_in_group("enemy"):
		print("2")
		body.take_damage(1)
		queue_free()
	elif body.is_in_group("wall"):
		queue_free()
