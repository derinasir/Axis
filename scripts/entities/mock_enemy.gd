extends CharacterBody3D

@onready var combat_manager: Node = $CombatManager
@export var combat_stats: CombatStats

@onready var mesh = $MeshInstance3D


func _ready() -> void:
	combat_manager.combat_stats = combat_stats.duplicate(true)
	
	var material = mesh.get_surface_override_material(0)
	var material_copy = material.duplicate()
	mesh.set_surface_override_material(0, material_copy)


func _on_combat_manager_died(_data: DamageData) -> void:
	%AnimationPlayer.play("die")


func _on_combat_manager_took_damage(_data: DamageData) -> void:
	%AnimationPlayer.play("take_damage")
	
