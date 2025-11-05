extends CharacterBody2D

# Player properties
var last_direction: int = 1

@onready var hero_sword: Area2D = $"HeroSword"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: State = $StateMachine

func _ready() -> void:
	# The state machine will handle all movement logic
	pass
	
func play_run() -> void:
	if animated_sprite_2d:
		animated_sprite_2d.play("run")

func play_idle() -> void:
	if animated_sprite_2d:
		animated_sprite_2d.play("idle")
		
func flip_sword(value: bool) -> void:
	if hero_sword:
		hero_sword.flip_sword(value)
