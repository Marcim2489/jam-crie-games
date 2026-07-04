extends BossState

var lancouXingo : bool = false

func enterState():
	lancouXingo = false
	match boss.getPlayerAproxDirection():
		Vector2.RIGHT:
			boss.sprite.play("lado xingo")
			boss.sprite.flip_h = false
		Vector2.LEFT:
			boss.sprite.play("lado xingo")
			boss.sprite.flip_h = true
		Vector2.UP:
			boss.sprite.play("costas xingo")
			boss.sprite.flip_h = false
		Vector2.DOWN:
			boss.sprite.play("frente xingo")
			boss.sprite.flip_h = false
	await boss.sprite.animation_finished
	boss.lancarXingo()
	lancouXingo = true

func updateState(_delta: float) -> BossState:
	if lancouXingo == false:
		return null
	return boss.statesKeeper.states[0]

func exitState():
	lancouXingo = false
