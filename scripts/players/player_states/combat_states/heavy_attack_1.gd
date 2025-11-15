extends CombatState


func enter() -> void:
	player.is_attacking = true
	return_not_attacking_state = false
	hitbox.damage_data = damage_data
	
	%AnimationTree.set("parameters/HeavyAttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	var playback = %AnimationTree.get("parameters/Combat/playback")
	playback.travel("slash_1")
	player.combat_manager.drain_stamina(stamina_cost)
