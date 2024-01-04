extends Node

var character_gold:int = 0
var character_experience:int = 0

var next_room_is_trader = 0
var room_counter:int = 0
var remaining_enemies:int = 0

const DEBUG = 1
const TO_TRADER = 1
const INF_HEALTH = 0
const OPEN_DOORS = 0

const INTERACTABLE_COIN = "res://interactables/coin.tscn"
const ROOM_TRADER = "res://rooms/trader/trader_room.tscn"
const ROOM_NORMAL = [
	"res://rooms/normal_rooms/room_1.tscn",
	#"res://rooms/normal_rooms/room_2.tscn"
	"res://rooms/normal_rooms/room_3.tscn",	
]
const ROOM_TUTORIAL = "res://rooms/tutorial/tutorial.tscn"

var enemy_melee_cls = load("res://enemy/melee/hunter.tscn")
var enemy_melee_paths = [
	"res://enemy/melee/hunter.tscn",
	"res://enemy/melee/minion.tscn",
	"res://enemy/melee/tank.tscn",
]
var enemy_ranged_paths = [
	"res://enemy/melee/range.tscn",
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
@warning_ignore("unused_parameter")
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

func spawn_all_enemies(room):
	var spawn_points = room.get_node("EnemySpawnPoint")
	if spawn_points == null:
		print("Warn: no spawn points available")
	else:
		print("Debug: spawning", len(spawn_points.get_children()), " enemies")
		for point in spawn_points.get_children():
			self.spawn_enemy("random",point.global_position)
			
func remove_all_enemies():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.queue_free()
				
func on_player_character_died():
	current_room.queue_free()
	remove_all_enemies()
	enter_new_room("tutorial")
	PLAYER_CHARACTER.full_character_reset()

func on_enemy_died(at_position):
	remaining_enemies -= 1
	var new_coin = load("res://interactables/coin.tscn").instantiate()
	new_coin.global_position = at_position
	self.add_child(new_coin)
	if remaining_enemies <= 0:
		open_exit_door()

func open_exit_door():
	print("Unlocking door")
	var doorblocker = get_tree().get_first_node_in_group("door_blocker")
	if doorblocker != null:
		doorblocker.queue_free()
	else:
		print("Warn: doorblocker does not exist")

func generate_new_room(room):
	var new_room_cls = 0
		
	if room == "tutorial":
		new_room_cls = load(ROOM_TUTORIAL)
		room_counter = 0
	elif room_counter >= randi_range(3,5):
		new_room_cls = load(ROOM_TRADER)
		room_counter = 0
	else:
		new_room_cls = load(ROOM_NORMAL.pick_random())
		room_counter += 1
		
	if DEBUG and TO_TRADER:
		new_room_cls = load(ROOM_TRADER)
	print("Debug: Spawning new room")
	return new_room_cls.instantiate()
	
func enter_new_room(room="normal"):
	remaining_enemies = 0
	var new_room = generate_new_room(room)
	self.add_child(new_room)
	current_room = new_room
	
	var new_pos = new_room.get_node("EnterPoint").global_position
	PLAYER_CHARACTER.set_global_position(new_pos)
	remove_all_enemies()
	spawn_all_enemies(new_room)
	if remaining_enemies <= 0:
		open_exit_door()
	if DEBUG and OPEN_DOORS:
		open_exit_door()
	if DEBUG and INF_HEALTH:
		PLAYER_CHARACTER.running_LP = 100000
