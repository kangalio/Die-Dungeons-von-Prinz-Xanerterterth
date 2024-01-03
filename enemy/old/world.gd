extends Node2D

var hunter = load("res://Enemy/special_moving/predator.tscn")

func _ready():
	self.add_child(hunter.instantiate())

func _process(delta):
	pass
