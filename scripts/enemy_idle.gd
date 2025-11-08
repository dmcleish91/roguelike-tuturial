extends State

@export var min_idle_time: float = 2.0
@export var max_idle_time: float = 5.0
@export var wander_chance: float = 0.7  # 70% chance to wander

var idle_timer: float = 0.0
var next_decision_time: float = 0.0

func enter() -> void:
	owner.play_idle()
	owner.velocity = Vector2.ZERO
	# Set a random time before next decision
	next_decision_time = randf_range(min_idle_time, max_idle_time)
	idle_timer = 0.0

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	if owner.target != null:
		Transitioned.emit(self, "EnemyChase")
		return
		
	idle_timer += delta
	
	# Check if it's time to make a decision
	if idle_timer >= next_decision_time:
		if randf() < wander_chance:
			Transitioned.emit(self, "EnemyWander")
			return
		else:
			# Reset timer to idle longer
			idle_timer = 0.0
			next_decision_time = randf_range(min_idle_time, max_idle_time)
	
	# Keep the enemy stationary
	owner.velocity = Vector2.ZERO
	owner.move_and_slide()
