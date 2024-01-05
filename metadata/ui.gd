extends Control

@onready var money_label = $Label
@onready var hearts = [$UiHeartEmpty, $UiHeartEmpty2, $UiHeartEmpty3, $UiHeartEmpty4, $UiHeartEmpty5, $UiHeartEmpty6, $UiHeartEmpty7, $UiHeartEmpty8, $UiHeartEmpty9, $UiHeartEmpty10]
@onready var blackener = $ColorRect
@onready var hider = $ColorRect/Control
@onready var names_list = $ColorRect/Control/names_label
@onready var scores_label = $ColorRect/Control/scores_label
@onready var your_score = $ColorRect/Control/your_score
var screen_blackening_phase : String = ""

var number_of_rooms : int = 1
var new_save_name : String = "New_Save"
var current_saved_games = [["prefilled", 1], ["prefilled", 1], ["prefilled", 1], ["prefilled", 1], ["prefilled", 1]]

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
				hider.visible = true
		"fade_to_transparent":
			hider.visible = false
			blackener.color.a -= delta
			if blackener.color.a <= 0:
				screen_blackening_phase = ""
				GameManager.de_freeze_game()

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and hider.visible == true:
		save_game()
		screen_blackening_phase = "fade_to_transparent"

func create_new_savegame():
	if len($ColorRect/Control/LineEdit.text) > 0:
		return [$ColorRect/Control/LineEdit.text, number_of_rooms]

func save_game():
	current_saved_games.append(create_new_savegame())
	var min = current_saved_games[0][1]
	for saved_game in current_saved_games:
		if saved_game[1] < min:
			min = saved_game[1]
	for saved_game in current_saved_games:
		if saved_game[1] == min:
			current_saved_games.erase(saved_game)
			break
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = save_info()
	file.store_line(JSON.stringify(json_string))
	file.close()
	number_of_rooms = 0

func save_info():
	return {"current_saved_games" : current_saved_games}

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
		if len(node_data.current_saved_games) > 0:
			current_saved_games = node_data.current_saved_games
	print("curent_saved_data" + str(current_saved_games))
	for save_game in current_saved_games:
		names_list.text += save_game[0]
		names_list.text += "\n"
		scores_label.text += str(save_game[1])
		scores_label.text += "\n"
	your_score.text = str(number_of_rooms)
