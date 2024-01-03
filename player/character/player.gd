extends CharacterBody2D

var weapon = preload("res://player/upgrade/weapon01.tscn")

const MOVE_SPEED = 100
const ROTATION_SPEED = 0.05
var dash_cooldown : float = 2
var dash_length : float = 1
var facing_direction : float = -PI / 2
var weapon_reference
var LP = 10

func take_damage(ponts):
	LP = LP - ponts
	
	if LP <= 0:
		pass
		#jetzt in den äußeren Game Loop

func shoot():
	if Input.is_action_just_pressed("shoot"):
		weapon_reference.attack()

func _ready():
	var weapon_instance = weapon.instantiate()
	weapon_reference = weapon_instance
	self.add_child(weapon_instance)
	position = get_viewport_rect().get_center()

func do_movement_input(delta):
	if LP <= 0:
		return
	
	facing_direction += Input.get_axis("left", "right") * ROTATION_SPEED
	
	rotation = facing_direction + PI / 2
	velocity = Vector2.from_angle(facing_direction) * Input.get_axis("backward", "forward") * MOVE_SPEED
	
	if Input.is_key_pressed(KEY_SHIFT) and dash_cooldown <= 0:
		velocity *= 2
	
	dash_cooldown -= delta
	if dash_cooldown <= 0-dash_length:
		dash_cooldown = 2
		
	move_and_slide()
		
func add_upgrade(file_path):
	var upgrade = load(file_path).instantiate()
	if upgrade.is_weapon:
		weapon_reference.queue_free()
		weapon_reference = upgrade
		self.add_child(upgrade)

func _process(delta):
	do_movement_input(delta)
	shoot()
	
