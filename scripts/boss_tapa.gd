extends BossState

var proximoAoPlayer : bool = false
var deuTapa : bool = false
var iniciouTapa : bool = false
var posicaoDetectada : Vector2

func enterState():
	if boss.ultimoAtaqueTapa:
		boss.repetidos+=1
	else:
		boss.repetidos = 0
	boss.ultimoAtaqueTapa = true
	posicaoDetectada = boss.player.global_position
	match boss.getPlayerAproxDirection():
		Vector2.RIGHT:
			boss.sprite.play("lado tapa")
			boss.sprite.flip_h = false
		Vector2.LEFT:
			boss.sprite.play("lado tapa")
			boss.sprite.flip_h = true
		Vector2.UP:
			boss.sprite.play("costas tapa")
			boss.sprite.flip_h = false
		Vector2.DOWN:
			boss.sprite.play("frente tapa")
			boss.sprite.flip_h = false
	if boss.getPlayerDistance() <= 32:
		proximoAoPlayer = true
		tapao()
	else:
		boss.velocity = (boss.velocidadeMovimento * 
		boss.getPlayerDirection())
	

func updateState(_delta: float) -> BossState:
	if proximoAoPlayer == false and deuTapa == false and iniciouTapa == false:
		if boss.global_position.distance_to(posicaoDetectada) <= 32:
			proximoAoPlayer = true
	if proximoAoPlayer and deuTapa == false and iniciouTapa == false:
		tapao()
	if deuTapa:
		return boss.statesKeeper.states[0]
	
	return null

func tapao():
	boss.velocity = Vector2.ZERO
	iniciouTapa = true
	boss.darTapa()
	await boss.animPlayer.animation_finished
	deuTapa = true

func exitState():
	proximoAoPlayer = false
	deuTapa = false
	iniciouTapa = false
