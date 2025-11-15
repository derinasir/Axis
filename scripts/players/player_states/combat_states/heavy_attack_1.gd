extends CombatState


func enter() -> void:
	super()
	
	%AnimationTree.set("parameters/HeavyAttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	var playback = %AnimationTree.get("parameters/Combat/playback")
	playback.travel("slash_1")
