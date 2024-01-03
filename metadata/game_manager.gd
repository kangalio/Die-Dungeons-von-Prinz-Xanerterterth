extends Node

var character_gold:int = 0
var character_experience:int = 0

var next_room_is_trader = 0

const ROOM_TRADER = "res://rooms/trader/trader_room.tscn"
const ROOM_NORMAL = "res://rooms/normal_rooms/room_1.tscn"

var enemy_melee_cls = load("res://enemy/melee/melee_enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy(enemy_type, position):
	var enemy = 0
	if enemy_type == "melee":
		enemy = enemy_melee_cls.instantiate()
	else:
		enemy = enemy_melee_cls.instantiate()
	self.add_child(enemy)
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
	for point in new_room.get_node("EnemySpawnPoints").get_children():
		self.spawn_enemy("melee",point.global_position)
	
	
