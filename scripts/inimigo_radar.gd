extends Entidade
class_name Radar

@export var velocidadeProjetil : int = 150
@export var animSprite : AnimatedSprite2D
@export var cooldownAtaque : Timer
var atacando : bool = false
var player : Player
const PROJETIL_INIMIGO_MULTA = preload("uid://qjjunnrqiwqq")

func _ready() -> void:
	if(hurtbox != null):
		hurtbox.morreu.connect(morrer)
	player = get_tree().get_first_node_in_group("Player")
	cooldownAtaque.start()

func _process(_delta: float) -> void:
	if atacando:
		return
	var direcaoPlayer : Vector2 = (player.global_position - 
	global_position).normalized()
	var xAbs : float = direcaoPlayer.x
	if xAbs<0:
		xAbs *= -1
	var yAbs : float = direcaoPlayer.y
	if yAbs<0:
		yAbs *= -1
	if xAbs >= yAbs:
		animSprite.play("lado")
		if direcaoPlayer.x <0:
			animSprite.flip_h = true
			animSprite.offset.x = -3
		else:
			animSprite.flip_h = false
			animSprite.offset.x = 0
	else:
		animSprite.flip_h = false
		animSprite.offset.x = 0
		if direcaoPlayer.y <0:
			animSprite.play("costas")
		else:
			animSprite.play("frente")
	if cooldownAtaque.is_stopped():
		atacar(direcaoPlayer)
		atacando = true

func atacar(direcao : Vector2):
	var xAbs : float = direcao.x
	if xAbs<0:
		xAbs *= -1
	var yAbs : float = direcao.y
	if yAbs<0:
		yAbs *= -1
	if xAbs >= yAbs:
		animSprite.play("ataque lado")
		if direcao.x <0:
			animSprite.flip_h = true
			animSprite.offset.x = -3
		else:
			animSprite.flip_h = false
			animSprite.offset.x = 0
	else:
		animSprite.flip_h = false
		animSprite.offset.x = 0
		if direcao.y <0:
			animSprite.play("ataque costas")
		else:
			animSprite.play("ataque frente")
	await animSprite.animation_finished
	var projetil : Projetil = PROJETIL_INIMIGO_MULTA.instantiate()
	guardaProjetil.add_child(projetil)
	projetil.global_position = global_position + direcao * 16
	projetil.lancar(velocidadeProjetil, direcao)
	cooldownAtaque.start()
	atacando = false
