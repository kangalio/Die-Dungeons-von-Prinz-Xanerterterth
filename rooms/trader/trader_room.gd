extends Node2D

func _ready():
	print("trade room in scene")
	for item_position in [Vector2(696 + 96, 448), Vector2(456 +96, 448), Vector2(216+96, 448)]:
		spawn_interactable(return_interactable(), item_position)
	GameManager.open_exit_door()
	
func return_interactable():
	return [
		"res://interactables/DMG_boost_on_floor.tscn", 
		"res://interactables/helposchen_on_floor.tscn", 
		"res://interactables/speed_bost_on_floor.tscn",
		"res://interactables/magic_attack_on_floor.tscn",
		"res://interactables/sword_on_floor.tscn",
		"res://interactables/hammer_on_floor.tscn",
		"res://interactables/dash_boost_on_floor.tscn",
		"res://interactables/armor_on_floor.tscn"
	].pick_random()

func spawn_interactable(file_path, position):
	var interactable = load(file_path).instantiate()
	self.add_child(interactable)
	interactable.set_global_position(position)
