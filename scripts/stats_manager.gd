extends Node
class_name StatsManager

signal stat_changed(stat_name: String, old_value: float, new_value: float)
signal stat_depleted(stat_name: String)

class StatData:
	var current: float
	var max_value: float
	var min_value: float
	var regen_rate: float = 0.0
	
	func _init(_max: float, _min: float = 0.0) -> void:
		max_value = _max
		min_value = _min
		current = _max
		
var stats: Dictionary[String, StatData] = {}

func _process(delta: float) -> void:
	for stat_name: String in stats:
		var stat: StatData = stats[stat_name]
		if stat.regen_rate > 0 and stat.current < stat.max_value:
			modify_stat(stat_name, stat.regen_rate * delta)

func add_stat(stat_name: String, max_val: float, min_val: float = 0.0, regen: float = 0.0) -> void:
	var stat_data: StatData = StatData.new(max_val, min_val)
	stat_data.regen_rate = regen
	stats[stat_name] = stat_data
	
	
func modify_stat(stat_name: String, amount: float) -> bool:
	if not stats.has(stat_name):
		push_error("Stat '%s' does not exist!" % stat_name)
		return false
	
	var stat: StatData = stats[stat_name]
	var old_value: float = stat.current
	stat.current = clampf(stat.current + amount, stat.min_value, stat.max_value)
	
	if old_value != stat.current:  # Only emit if value actually changed
		stat_changed.emit(stat_name, old_value, stat.current)
	
	if stat.current == stat.min_value and old_value > stat.min_value:
		stat_depleted.emit(stat_name)
	
	return true
	
func get_stat(stat_name: String) -> float:
	if not stats.has(stat_name):
		push_error("Stat '%s' does not exist!" % stat_name)
		return 0.0
	return stats[stat_name].current
	
func get_stat_max(stat_name: String) -> float:
	if not stats.has(stat_name):
		push_error("Stat '%s' does not exist!" % stat_name)
		return 0.0
	return stats[stat_name].max_value
		
func get_stat_percentage(stat_name: String) -> float:
	if not stats.has(stat_name):
		return 0.0
	var stat: StatData = stats[stat_name]
	return stat.current / stat.max_value if stat.max_value > 0 else 0.0
	
func set_stat_to_max(stat_name: String) -> void:
	if stats.has(stat_name):
		var stat: StatData = stats[stat_name]
		modify_stat(stat_name, stat.max_value - stat.current)
		
func has_stat(stat_name: String) -> bool:
	return stats.has(stat_name)
		
		
		
