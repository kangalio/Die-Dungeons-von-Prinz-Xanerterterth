extends Area2D

@export var upgrade:String = ""
@export var cost:int = 0

var player_is_close:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	if Input.is_action_just_pressed("interact") and player_is_close == true and PLAYER_CHARACTER.money >= cost:
		PLAYER_CHARACTER.add_upgrade(upgrade)
		PLAYER_CHARACTER.money = PLAYER_CHARACTER.money - cost
		print('current money = ',PLAYER_CHARACTER.money)
		print('interacted')
		self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	interact()
	pass

func _on_body_entered(body):
	if body == PLAYER_CHARACTER:
		player_is_close = true

func _on_body_exited(body):
	if body == PLAYER_CHARACTER:
		player_is_close = false
