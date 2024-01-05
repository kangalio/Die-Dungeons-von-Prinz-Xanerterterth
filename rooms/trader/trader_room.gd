extends Node2D


var removed_door : int = 0
var weapons_list = ["res://interactables/magic_attack_on_floor.tscn", 
					"res://interactables/sword_on_floor.tscn",
					"res://interactables/bouncy_cannon_on_floor.tscn"]
						
var upgrades_list = ["res://interactables/speed_bost_on_floor.tscn",
					"res://interactables/hammer_on_floor.tscn",
					"res://interactables/armor_on_floor.tscn",
					"res://interactables/dash_boost_on_floor.tscn",
					"res://interactables/DMG_boost_on_floor.tscn",
					
					]

func _ready():
	spawn_interactable(return_interactable(upgrades_list), Vector2(576 - 192, 448))
	spawn_interactable(return_interactable(weapons_list), Vector2(576, 448))
	spawn_interactable(return_interactable(upgrades_list), Vector2(576 + 192, 448))
	
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
