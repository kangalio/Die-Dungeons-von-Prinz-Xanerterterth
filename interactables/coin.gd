extends Area2D

# Called when the node enters the scene tree for the first time.
func _on_body_entered(body):
	# if body == PLAYER_CHARACTER:
	PLAYER_CHARACTER.money = PLAYER_CHARACTER.money + 1
	print('money money money')
	self.queue_free()
