extends State
class_name PlayerWalk

@export var move_speed: float = 40.0

func enter() -> void:
		owner.play_run()

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	# Check for attack input first (spacebar)
	if Input.is_action_just_pressed("ui_accept"):
		owner.attack()

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
		owner.last_direction = input_vector.x
		var flip_direction: bool = owner.last_direction < 0
		owner.flip_hero(flip_direction)
		owner.flip_sword(flip_direction)

	# If no input, transition to idle
	if input_vector == Vector2.ZERO:
		Transitioned.emit(self, "PlayerIdle")
		return

	# Move the player
	owner.velocity = input_vector.normalized() * move_speed
	owner.move_and_slide()
