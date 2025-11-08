extends CharacterBody2D

# Player properties
var last_direction: int = 1
@onready var stats: StatsManager = $StatsManager
@onready var weapon: Marker2D = $Weapon
@onready var hero_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hero_sword: Area2D = $Weapon/HeroSword

func _ready() -> void:
	stats.add_stat("health", 100.0)
	stats.add_stat("stamina", 100.0, 0.0, 10.0)
	stats.stat_changed.connect(_on_stat_changed)
	stats.stat_changed.connect(_on_stat_depleted)

func play_run() -> void:
	if hero_sprite_2d:
		hero_sprite_2d.play("run")

func play_idle() -> void:
	if hero_sprite_2d:
		hero_sprite_2d.play("idle")
		
func flip_hero(value: bool) -> void:
	hero_sprite_2d.flip_h = value
		
func flip_sword(value: bool) -> void:
	if value == true:
		weapon.scale.x = -1
	else:
		weapon.scale.x = 1
		
func attack() -> void:
	if hero_sword:
		hero_sword.sword_attack()
		
func take_damage(amount: float) -> void:
	stats.modify_stat("health", -amount)
	print("Took %d damage!" % amount)
	
func heal(amount: float) -> void:
	stats.modify_stat("health", amount)
	print("Healed %d!" % amount)
	
func _on_stat_changed(stat_name: String, old_val: float, new_val: float) -> void:
	print("%s changed: %.1f -> %.1f (%.0f%%)" % [
		stat_name, 
		old_val, 
		new_val,
		stats.get_stat_percentage(stat_name) * 100
	])

func _on_stat_depleted(stat_name: String) -> void:
	print("%s depleted!" % stat_name)
	if stat_name == "health":
		die()

func die() -> void:
	print("Player died!")
