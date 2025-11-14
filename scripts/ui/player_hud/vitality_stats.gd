extends VBoxContainer

@export var player: Player


@onready var health_bar: ProgressBar = $HealthBar
@onready var stamina_bar: ProgressBar = $StaminaBar


func _process(delta: float) -> void:
	health_bar.value = player.combat_manager.combat_stats.health
	stamina_bar.value = player.combat_manager.combat_stats.stamina
