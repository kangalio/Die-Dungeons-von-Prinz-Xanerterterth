extends Node2D

var upgrade = "res://player/upgrades/upgrade.tscn"

var player_is_close:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func interact():
	if Input.is_action_just_pressed("interact") and player_is_close:
		PLAYER_CHARACTER.add_upgrade(upgrade)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	interact()
	pass

func _on_body_entered(body):
	# if body == PLAYER_CHARACTER:
	player_is_close = true

func _on_body_exited(body):
	# if body == PLAYER_CHARACTER:
	player_is_close = false
