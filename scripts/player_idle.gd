extends State
class_name PlayerIdle

func enter() -> void:
	owner.play_idle()
	owner.velocity = Vector2.ZERO

func exit()  -> void:
	pass

func update(_delta: float)  -> void:
	pass

func physics_process(_delta: float) -> void:
	# Check for attack input first (spacebar)
	if Input.is_action_just_pressed("ui_accept"):
		owner.attack()

	# Check for any movement input
	var has_input: bool = (
		Input.is_action_pressed("ui_up") or
		Input.is_action_pressed("ui_down") or
		Input.is_action_pressed("ui_left") or
		Input.is_action_pressed("ui_right")
	)

	# If there's input, transition to walk
	if has_input:
		Transitioned.emit(self, "PlayerWalk")
		return

	# Keep the player stationary
	owner.velocity = Vector2.ZERO
	owner.move_and_slide()
