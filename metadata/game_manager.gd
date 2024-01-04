extends Node

var character_gold:int = 0
var character_experience:int = 0

var next_room_is_trader = 0

const ROOM_TRADER = "res://rooms/trader/trader_room.tscn"
const ROOM_NORMAL = "res://rooms/normal_rooms/room_1.tscn"

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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy(enemy_type, position, room):
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
	room.add_child(enemy)
	enemy.set_global_position(position)

	
func enter_new_room():
	var new_room = 0
	var new_room_cls = 0
	if next_room_is_trader:
		new_room_cls = load(ROOM_TRADER)
		next_room_is_trader = 0
	else:
		new_room_cls = load(ROOM_NORMAL)
		next_room_is_trader = 1
	new_room = new_room_cls.instantiate()
	self.add_child(new_room)
	var new_pos = new_room.get_node("EnterPoint").global_position
	PLAYER_CHARACTER.set_global_position(new_pos)
	var spawn_points = new_room.get_node("EnemySpawnPoint")
	if spawn_points == null:
		print("Warn: no spawn points available")
	else:
		for point in spawn_points.get_children():
			print("spawning enemy at ",point.global_position)
			self.spawn_enemy("random",point.global_position, new_room)
