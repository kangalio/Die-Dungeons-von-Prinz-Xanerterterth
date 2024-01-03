extends CharacterBody2D


const MOVE_SPEED = 100
const ROTATION_SPEED = 0.05
var dash_cooldown : float = 2
var dash_length : float = 1
var facing_direction : float = -PI / 2

var LP = 10

func take_damage(ponts):
	LP = LP - ponts
	
	if LP <= 0:
		pass
		#jetzt in den äußeren Game Loop


var bullet_scene = preload("res://player/character/bullet.tscn")

func _ready():
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

func do_bullet_input():
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		bullet.position = self.position
		bullet.velocity = Vector2.from_angle(facing_direction) * 15
		add_sibling(bullet)
		_do_recoil(1)

func _do_recoil(strength):
	pass
	#den Player zurücksetzen und dan wieder vor ( nicht wichtig aber schön)
	
func _process(delta):
	do_movement_input(delta)
	do_bullet_input()
	move_and_slide()
