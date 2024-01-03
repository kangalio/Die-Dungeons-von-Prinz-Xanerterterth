extends CharacterBody2D

var speed = 500
var slipperiness = 0.01

var bullet_scene = preload("res://spieler/character/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func do_movement_input(delta):
	velocity *= pow(slipperiness, delta)
	
	if Input.is_key_pressed(KEY_W):
		velocity.y = -speed
	if Input.is_key_pressed(KEY_S):
		velocity.y = speed
	if Input.is_key_pressed(KEY_A):
		velocity.x = -speed
	if Input.is_key_pressed(KEY_D):
		velocity.x = speed

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
