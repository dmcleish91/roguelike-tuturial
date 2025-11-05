extends CharacterBody2D

# Player properties
var last_direction: int = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var state_machine = $StateMachine

func _ready():
	# The state machine will handle all movement logic
	pass
