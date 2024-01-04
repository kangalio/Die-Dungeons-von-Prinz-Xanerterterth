extends CharacterBody2D

var weapon = preload("res://player/upgrade/standart_weapon.tscn")

var speed = 10000
var weapon_reference
var player_direction : Vector2 = Vector2(0, -1)

var base_LP = 10
var running_LP : int = 10

func take_damage(ponts):
	running_LP = running_LP - ponts
	
	if running_LP <= 0:
		pass
		#jetzt in den äußeren Game Loop

func _ready():
	var weapon_instance = weapon.instantiate()
	weapon_reference = weapon_instance
	self.add_child(weapon_instance)
	position = get_viewport_rect().get_center()

func add_upgrade(file_path):
	var upgrade = load(file_path).instantiate()
	if upgrade.is_weapon:
		weapon_reference.queue_free()
		weapon_reference = upgrade
		self.add_child(upgrade)

func _input(event):
	if Input.is_action_just_pressed("shoot") and running_LP >= 0:
		weapon_reference.attack()

func _process(delta):
	#do_movement_input(delta)
	alternative_movement(delta)
	alternative_direction()

func alternative_movement(delta):
	if running_LP >= 0:
		var direction = Input.get_vector("left", "right", "forward", "backward")
		self.velocity = direction.normalized() * speed * delta
		move_and_slide()

func alternative_direction():
	if Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").length() != 0:
		player_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
