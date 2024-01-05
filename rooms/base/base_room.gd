extends Node2D

var room_left = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func exit_room():
	if not room_left:
		print("Debug: Exiting room ", self.get_parent())
		PLAYER_CHARACTER.set_global_position(self.get_parent().get_node("EnterPoint").global_position)
		GameManager.enter_new_room()
		room_left = 1
	self.get_parent().queue_free()


func enter_room():
	#var new_room_cls = 0
	#if room_type == "merchant":
		#new_room_cls = load(ROOM_TRADER_NAME)
	#elif room_type == "normal":
		#new_room_cls = load(room_names.pick_random())
	#else:
		#new_room_cls = load(room_names.pick_random())
	#self.add_sibling(new_room_cls.instantiate())
	pass
	
