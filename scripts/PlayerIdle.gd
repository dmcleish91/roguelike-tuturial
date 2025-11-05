extends State
class_name PlayerIdle

var player: CharacterBody2D

func Enter() -> void:
	player = owner as CharacterBody2D
	player.play_idle()
	player.velocity = Vector2.ZERO

func Exit()  -> void:
	pass

func Update(_delta: float)  -> void:
	pass

func Physics_Process(delta: float) -> void:
	if not player:
		return

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
	player.velocity = Vector2.ZERO
	player.move_and_slide()
