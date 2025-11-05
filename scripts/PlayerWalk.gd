extends State
class_name PlayerWalk

@export var move_speed: float = 40.0

var player: CharacterBody2D

func Enter():
	player = owner as CharacterBody2D
	if player:
		player.play_run()

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Process(delta: float):
	if not player:
		return

	var input_vector: Vector2 = Vector2.ZERO

	# Get input direction
	if Input.is_action_pressed("ui_up"):
		input_vector.y = -1
	if Input.is_action_pressed("ui_down"):
		input_vector.y = 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x = -1
	if Input.is_action_pressed("ui_right"):
		input_vector.x = 1

	# Update sprite direction
	if input_vector.x != 0:
		player.last_direction = input_vector.x
	if player.has_node("AnimatedSprite2D"):
		var flip_direction = player.last_direction < 0
		player.get_node("AnimatedSprite2D").flip_h = flip_direction
		player.flip_sword(flip_direction)

	# If no input, transition to idle
	if input_vector == Vector2.ZERO:
		Transitioned.emit(self, "PlayerIdle")
		return

	# Move the player
	player.velocity = input_vector.normalized() * move_speed
	player.move_and_slide()
