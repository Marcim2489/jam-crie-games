extends BossState

func enterState():
	boss.cooldownTimer.start()
	match boss.getPlayerAproxDirection():
		Vector2.RIGHT:
			boss.sprite.play("lado")
			boss.sprite.flip_h = false
		Vector2.LEFT:
			boss.sprite.play("lado")
			boss.sprite.flip_h = true
		Vector2.UP:
			boss.sprite.play("costas")
			boss.sprite.flip_h = false
		Vector2.DOWN:
			boss.sprite.play("frente")
			boss.sprite.flip_h = false

func updateState(_delta: float) -> BossState:
	match boss.getPlayerAproxDirection():
		Vector2.RIGHT:
			boss.sprite.play("lado")
			boss.sprite.flip_h = false
		Vector2.LEFT:
			boss.sprite.play("lado")
			boss.sprite.flip_h = true
		Vector2.UP:
			boss.sprite.play("costas")
			boss.sprite.flip_h = false
		Vector2.DOWN:
			boss.sprite.play("frente")
			boss.sprite.flip_h = false
	if boss.cooldownTimer.is_stopped():
		#return boss.statesKeeper.states[1]
		if boss.repetidos <=2:
			return [boss.statesKeeper.states[1],
			boss.statesKeeper.states[2]].pick_random()
		if boss.ultimoAtaqueTapa:
			return boss.statesKeeper.states[1]
		else:
			return boss.statesKeeper.states[2]
	return null
