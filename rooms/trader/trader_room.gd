extends Node2D

func _ready():
	for item_position in [Vector2(696, 448), Vector2(456, 448), Vector2(448, 448)]:
		spawn_interactable(return_interactable(), item_position)
	GameManager.open_exit_door()
	
func return_interactable():
	return ["res://interactables/DMG_boost_on_floor.tscn", "res://interactables/helposchen_on_floor.tscn", "res://interactables/speed_bost_on_floor.tscn",].pick_random()

func spawn_interactable(file_path, position):
	var interactable = load(file_path).instantiate()
	self.add_child(interactable)
	interactable.set_global_position(position)
