extends Control

@onready var money_label = $Label
@onready var hearts = [$UiHeartEmpty, $UiHeartEmpty2, $UiHeartEmpty3, $UiHeartEmpty4, $UiHeartEmpty5, $UiHeartEmpty6, $UiHeartEmpty7, $UiHeartEmpty8, $UiHeartEmpty9, $UiHeartEmpty10]

func _ready():
	pass # Replace with function body.

func _process(delta):
	money_label.text = str(PLAYER_CHARACTER.money)
	for i in len(hearts):
		if i < PLAYER_CHARACTER.running_LP:
			hearts[i].texture = load("res://16x16_sprites/charakter_sprites/0x72_DungeonTilesetII_v1.6/frames/ui_heart_full.png")
		else:
			hearts[i].texture = load("res://16x16_sprites/charakter_sprites/0x72_DungeonTilesetII_v1.6/frames/ui_heart_empty.png")
