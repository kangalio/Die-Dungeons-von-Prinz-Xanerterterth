extends Control

@onready var money_label = $Label
@onready var hearts = [$UiHeartEmpty, $UiHeartEmpty2, $UiHeartEmpty3, $UiHeartEmpty4, $UiHeartEmpty5, $UiHeartEmpty6, $UiHeartEmpty7, $UiHeartEmpty8, $UiHeartEmpty9, $UiHeartEmpty10]
@onready var blackener = $ColorRect
var screen_blackening_phase : String = ""
var fade_cooldown : float = 1

var number_of_rooms : int = 1
var new_save_name : String = "New_Save"
var current_saved_games = []

func _ready():
	pass # Replace with function body.

func _process(delta):
	money_label.text = str(PLAYER_CHARACTER.money)
	for i in len(hearts):
		if i < PLAYER_CHARACTER.running_LP:
			hearts[i].texture = load("res://16x16_sprites/charakter_sprites/0x72_DungeonTilesetII_v1.6/frames/ui_heart_full.png")
		else:
			hearts[i].texture = load("res://16x16_sprites/charakter_sprites/0x72_DungeonTilesetII_v1.6/frames/ui_heart_empty.png")
	match screen_blackening_phase:
		"fade_to_black":
			blackener.color.a += delta
			if blackener.color.a >= 1:
				screen_blackening_phase = ""
		"fade_to_transparent":
			blackener.color.a -= delta
			if blackener.color.a <= 0:
				screen_blackening_phase = ""
				GameManager.de_freeze_game()

func save_game():
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = save_info()
	file.store_line(JSON.stringify(json_string))
	file.close()
	pass

func save_info():
	return {"number_of_rooms" : number_of_rooms,
	"name" : new_save_name,
	"current_saved_games" : current_saved_games}
	
func load_game():
	var node_data
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	var saved_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json_string = saved_game.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string, true)
	if parse_result == OK:
		node_data = json.get_data()
		number_of_rooms = node_data.number_of_rooms
		new_save_name = node_data.new_save_name
		current_saved_games = node_data.current_saved_games
