extends Node

signal died(damage_data: DamageData)
signal took_damage(damage_data: DamageData)
signal struck(damage_data: DamageData)

@export var damage_data: DamageData
@export var combat_stats: CombatStats

@export var hurtbox: Hurtbox
@export var hitbox: Hitbox



func _ready() -> void:
	hitbox.damage_data = damage_data
	hurtbox.was_hit.connect(_on_was_hit)
	hitbox.struck.connect(_on_struck)


func take_damage(data: DamageData):
	combat_stats.health -= data.damage_value
	if combat_stats.health <= 0:
		died.emit(data)
	else:
		took_damage.emit(data)



func _on_was_hit(data: DamageData):
	take_damage(data)


func _on_struck():
	struck.emit(damage_data)
