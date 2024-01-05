extends Node2D


var removed_door : int = 0
var weapons_list = ["res://interactables/magic_attack_on_floor.tscn", "res://interactables/sword_on_floor.tscn"]
var upgrades_list = ["res://interactables/armor_on_floor.tscn", "res://interactables/speed_bost_on_floor.tscn","res://interactables/hammer_on_floor.tscn"]

func _ready():
	spawn_interactable(return_interactable(upgrades_list), Vector2(696 + 96, 448))
	spawn_interactable(return_interactable(weapons_list), Vector2(456 +96, 448))
	spawn_interactable(return_interactable(upgrades_list), Vector2(216+96, 448))
	GameManager.open_exit_door()
	
func return_interactable(list):
	var new_interacable = list.pick_random()
	list.erase(new_interacable)
	return new_interacable

func spawn_interactable(file_path, position):
	var interactable = load(file_path).instantiate()
	self.add_child(interactable)
	interactable.set_global_position(position)


func _process(delta):
	if removed_door == 0:
		removed_door = 1
	elif removed_door == 1:
		GameManager.open_exit_door()
		removed_door = 3
