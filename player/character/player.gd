extends CharacterBody2D

var starting_weapon = preload("res://player/upgrade/standart_weapon.tscn")


var weapon_reference
var player_direction : Vector2 = Vector2(0, -1)

var base_LP : int = 10
var running_LP : int = base_LP

var bonus_damage : int = 0

var base_speed = 7500
var bonus_speed : int = 0

var base_money : int = 100
var money : int = base_money

var base_armor : int = 0
var armor : int = 0

func take_damage(points):
	var delta = points - armor
	if delta < 1:
		delta = 1
	running_LP = running_LP - delta
	
	if running_LP <= 0:
		GameManager.on_player_character_died()
		#jetzt in den äußeren Game Loop

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	var weapon_instance = starting_weapon.instantiate()
	weapon_reference = weapon_instance
	self.add_child(weapon_instance)
	position = get_viewport_rect().get_center()
	_animated_sprite.play("walk")


func add_upgrade(file_path):
	var upgrade = load(file_path).instantiate()
	if upgrade.is_weapon:
		weapon_reference.queue_free()
		weapon_reference = upgrade
		self.add_child(upgrade)
	
	else:
		self.add_child(upgrade)

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		weapon_reference.attack(bonus_damage) 

func _process(delta):
	alternative_movement(delta)
	alternative_direction()

func alternative_movement(delta):
	var direction = Input.get_vector("left", "right", "forward", "backward")
	self.velocity = direction.normalized() * (base_speed+bonus_speed) * delta
	if direction.length() > 0:
		_animated_sprite.play()
	else:
		_animated_sprite.stop()
	move_and_slide()

func alternative_direction():
	if Input.get_vector("left_shoot", "right_shoot", "forward_shoot", "backward_shoot").length() != 0:
		player_direction = Input.get_vector("left_shoot", "right_shoot", "forward_shoot", "backward_shoot")
	
func full_character_reset():
	bonus_damage = 0
	bonus_speed = 0
	running_LP = base_LP
	money = base_money
	
	weapon_reference.queue_free()
	weapon_reference = starting_weapon.instantiate()
	self.add_child(weapon_reference)
