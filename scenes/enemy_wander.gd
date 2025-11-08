extends State

@export var min_wander_distance: float = 20.0
@export var max_wander_distance: float = 50.0
@export var move_speed: float = 50.0

var target_position: Vector2
var start_position: Vector2
var wander_distance: float

func enter() -> void:
	owner.play_run()
	
	start_position = owner.global_position
	
	var random_angle: float = randf_range(0, TAU)
	var direction: Vector2 = Vector2(cos(random_angle), sin(random_angle))
	
	wander_distance = randf_range(min_wander_distance, max_wander_distance)
	
	target_position = start_position + (direction * wander_distance)
	
	print("Wandering to: ", target_position)

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	if owner.target != null:
		Transitioned.emit(self, "EnemyChase")
		return
		
	var direction: Vector2 = (target_position - owner.global_position).normalized()
	
	if direction.x != 0:
		owner.flip_direction(direction.x < 0)
	
	owner.velocity = direction * move_speed
	owner.move_and_slide()
	
	var distance_to_target: float = owner.global_position.distance_to(target_position)
	
	if distance_to_target < 5.0:  # 5 pixels close enough
		print("Reached destination, returning to idle")
		Transitioned.emit(self, "EnemyIdle")
