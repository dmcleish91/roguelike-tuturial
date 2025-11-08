extends State

@export var chase_speed: float = 20.0

func enter() -> void:
	owner.play_run()
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	if owner.target == null:
		Transitioned.emit(self, "EnemyWander")
		return
	var direction: Vector2 = (owner.target.global_position - owner.global_position).normalized()
	
	if direction.x != 0:
		owner.flip_direction(direction.x < 0)
		
	owner.velocity = direction * chase_speed
	owner.move_and_slide()
	
	# var distance_to_target: float = owner.global_position.distance_to(owner.target.global_position)
	# if distance_to_target < attack_range:
	#     Transitioned.emit(self, "EnemyAttack")
