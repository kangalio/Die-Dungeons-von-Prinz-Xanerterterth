extends Node2D

var exit_door = load("res://rooms/base/exit_door.tscn")
var room_names = ["res://rooms/normal_rooms/room_1.tscn","res://rooms/normal_rooms/room_1.tscn"]
const ROOM_TRADER_NAME = "res://rooms/trader/trader_room.tscn"
const ROOM_LOBBY = "res://rooms/"
# Called when the node enters the scene tree for the first time.
var current_room_layout = 0

func _ready():
	self.add_child(exit_door.instantiate())
	self.enter_room("normal")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func exit_room():
	self.current_room_layout.free_queued()
	

func enter_room(room_type):
	var new_room_cls = 0
	if room_type == "merchant":
		new_room_cls = load(ROOM_TRADER_NAME)
	elif room_type == "normal":
		new_room_cls = load(room_names.pick_random())
	else:
		new_room_cls = load(room_names.pick_random())
	self.current_room_layout = new_room_cls.instantiate()
	
