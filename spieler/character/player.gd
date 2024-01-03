extends CharacterBody2D


const SPEED = 10000.0
const JUMP_VELOCITY = -400.0
var dash_cooldown : float = 2
var dash_length : float = 1

var LP = 0

func take_damage(ponts):
	LP = LP - ponts
	
	if LP <= 0:
		pass
		#jetzt in den äußeren Game Loop


var bullet_scene = preload("res://spieler/character/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func do_movement_input(delta):
	velocity.x = 0
	velocity.y = 0
	if Input.is_key_pressed(KEY_W):
		velocity.y =-SPEED*delta
	if Input.is_key_pressed(KEY_S):
		velocity.y =SPEED*delta
	if Input.is_key_pressed(KEY_D):
		velocity.x =SPEED*delta
	if Input.is_key_pressed(KEY_A):
		velocity.x =-SPEED*delta
	if Input.is_key_pressed(KEY_SHIFT) and dash_cooldown <= 0:
		velocity *= 2
	
	dash_cooldown -= delta
	if dash_cooldown <= 0-dash_length:
		dash_cooldown = 2
		
	move_and_slide()

func do_bullet_input():
	if Input.is_action_just_pressed("ui_left") \
			or Input.is_action_just_pressed("ui_right") \
			or Input.is_action_just_pressed("ui_up") \
			or Input.is_action_just_pressed("ui_down"):
		var bullet_direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
		if bullet_direction != Vector2(0, 0):
			var bullet = bullet_scene.instantiate()
			bullet.position = self.position
			bullet.velocity = bullet_direction.normalized() * 15
			add_sibling(bullet)

func _process(delta):
	do_movement_input(delta)
	do_bullet_input()
	move_and_slide()
