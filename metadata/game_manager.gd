extends Node

var character_gold:int = 0
var character_experience:int = 0

var next_room_is_trader = 0
var room_counter:int = 0
var remaining_enemies:int = 0

const DEBUG = 1

const INTERACTABLE_COIN = "res://interactables/coin.tscn"
const ROOM_TRADER = "res://rooms/trader/trader_room.tscn"
const ROOM_NORMAL = [
	"res://rooms/normal_rooms/room_1.tscn",
	#"res://rooms/normal_rooms/room_2.tscn"	
]
const ROOM_TUTORIAL = "res://rooms/tutorial/tutorial.tscn"

var enemy_melee_cls = load("res://enemy/melee/hunter.tscn")
var enemy_melee_paths = [
	"res://enemy/melee/hunter.tscn",
	"res://enemy/melee/minion.tscn",
	"res://enemy/melee/tank.tscn",
]
var enemy_ranged_paths = [
	#"res://enemy/range/range_enemy.tscn"
]
var enemy_boss_paths = [
	"res://enemy/melee/hunter.tscn"
]
var enemy_all_paths = enemy_melee_paths + enemy_ranged_paths

var current_room
# Called when the node enters the scene tree for the first time.
func _ready():
	enter_new_room("tutorial")
	pass# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy(enemy_type, position):
	var enemy = 0
	var enemy_location = ""
	match enemy_type:
		"melee":
			enemy_location = enemy_melee_paths.pick_random()
		"random":
			enemy_location = enemy_all_paths.pick_random()
		"boss":
			enemy_location = enemy_boss_paths.pick_random()
	enemy = load(enemy_location).instantiate()
	self.add_child(enemy)
	enemy.set_global_position(position)
	remaining_enemies += 1

func on_player_character_died():
	current_room.queue_free()
	for enemy in get_tree().get_nodes_in_group("enemy"):
		print("removing enemy ",enemy)
		enemy.queue_free()
	enter_new_room("tutorial")

func on_enemy_died(at_position):
	remaining_enemies -= 1
	print("Enemy died, remaining = ",remaining_enemies)
	spawn_interactable(INTERACTABLE_COIN, at_position)
	if remaining_enemies <= 0:
		open_exit_door()

func spawn_interactable(file_path, position):
	var interactable = load(file_path).instantiate()
	self.add_child(interactable)
	interactable.set_global_position(position)
	
		
func open_exit_door():
	print("Unlocking door")
	var doorblocker = get_tree().get_first_node_in_group("door_blocker")
	if doorblocker != null:
		doorblocker.queue_free()
	else:
		print("Warn: doorblocker does not exist")
		
func enter_new_room(room="normal"):
	var new_room = 0
	var new_room_cls = 0
	remaining_enemies = 0
	
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()
		
	if room == "tutorial":
		new_room_cls = load(ROOM_TUTORIAL)
		room_counter = 0
	elif room_counter >= randi_range(3,5):
		new_room_cls = load(ROOM_TRADER)
		room_counter = 0
	else:
		new_room_cls = load(ROOM_NORMAL.pick_random())
		room_counter += 1
	print("Spawning new room", new_room_cls)
	new_room = new_room_cls.instantiate()
	self.add_child(new_room)
	current_room = new_room
	var new_pos = new_room.get_node("EnterPoint").global_position
	PLAYER_CHARACTER.set_global_position(new_pos)
	
	var spawn_points = new_room.get_node("EnemySpawnPoint")
	if spawn_points == null:
		print("Warn: no spawn points available")
	else:
		for point in spawn_points.get_children():
			self.spawn_enemy("random",point.global_position)
			
	if DEBUG:
		open_exit_door()
