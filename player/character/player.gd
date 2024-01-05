extends CharacterBody2D

var starting_weapon = preload("res://player/upgrade/standart_weapon.tscn")

var weapon_reference
var player_direction : Vector2 = Vector2(0, -1)

var base_LP : int = 10
var running_LP : int = base_LP

var bonus_damage : int = 0

var base_speed = 7500
var bonus_speed : int = 0

var base_money : int = 0
var money : int = base_money

var dash_duration_threshold : float = 0.1 #how long the dash lasts
var dash_charging_threshold_timer : float = 1# how long the dash charges
var dash_speed : int = 70000 # extra speed when dahing
var dash_cooldown_threshold : float = 5 #cooldown between two dash charge

var dash_cooldown : float = 0
var is_dashing = false
var dash_charging_timer: float 
var dash_started = false
var saved_bonus_speed: float
var dash_duration : float 

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

func dash(delta):
	$Node2D.update_bar()
	#testing if dashing
	if dash_cooldown >= 0: 
		dash_cooldown -= delta
	elif Input.is_action_just_pressed("dash") and dash_cooldown <= 0 :
		print("started charging dash")
		dash_started = true
		
		
		
	if Input.is_action_pressed("dash") and dash_started == true and dash_charging_timer <= dash_charging_threshold_timer:
		dash_charging_timer += delta
	
	if Input.is_action_just_released("dash") and dash_charging_timer >= dash_charging_threshold_timer and dash_started == true:
		if is_dashing == false and dash_duration == 0 :#start the dash
			saved_bonus_speed = bonus_speed
			bonus_speed = bonus_speed + dash_speed
			print("dash started")
			is_dashing = true
			dash_duration = 0
			dash_charging_timer = 0
			dash_started = false
			dash_cooldown = dash_cooldown_threshold
	elif Input.is_action_just_released("dash") and dash_charging_timer < dash_charging_threshold_timer and dash_started == true:
		print("canceled chaneling")
		dash_charging_timer = 0
		dash_started = false 
		dash_cooldown = 0
		
		
		
	if is_dashing == true and dash_duration <= dash_duration_threshold: 
		dash_duration += delta
		#print(str(dash_duration_threshold - dash_duration) + " remaining dash duration")
	elif is_dashing == true and dash_duration >= dash_duration_threshold :
		is_dashing = false
		bonus_speed = saved_bonus_speed
		dash_started = false
		dash_duration = 0 

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		weapon_reference.attack(bonus_damage) 

func _process(delta):
	alternative_movement(delta)
	alternative_direction()
	dash(delta)

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
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

func full_character_reset():
	bonus_damage = 0
	bonus_speed = 0
	running_LP = base_LP
	money = base_money
	for child in self.get_children():
		if child.is_in_group("ubgrade"):
			child.queue_free()
	weapon_reference.queue_free()
	weapon_reference = starting_weapon.instantiate()
	self.add_child(weapon_reference)
