extends State
class_name PlayerIdle

var player: CharacterBody2D

func Enter():
	player = owner as CharacterBody2D
	player.play_idle()
	player.velocity = Vector2.ZERO

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Process(delta: float):
	if not player:
		return

	# Check for any movement input
	var has_input = (
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
