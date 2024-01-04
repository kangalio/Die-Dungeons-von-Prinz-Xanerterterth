extends Node2D

var is_weapon:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	PLAYER_CHARACTER.bonus_speed = PLAYER_CHARACTER.bonus_speed + 5000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
