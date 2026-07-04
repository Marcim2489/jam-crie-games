extends Entidade
class_name Radar

@export var velocidadeProjetil : int = 150
@export var cooldownAtaque : Timer
var atacando : bool = false
var player : Player
const PROJETIL_INIMIGO_MULTA = preload("uid://qjjunnrqiwqq")

func _ready() -> void:
	if(hurtbox != null):
		hurtbox.morreu.connect(morrer)
		hurtbox.recebeuDano.connect(aoReceberDano)
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
		sprite.play("lado")
		if direcaoPlayer.x <0:
			sprite.flip_h = true
			sprite.offset.x = -3
		else:
			sprite.flip_h = false
			sprite.offset.x = 0
	else:
		sprite.flip_h = false
		sprite.offset.x = 0
		if direcaoPlayer.y <0:
			sprite.play("costas")
		else:
			sprite.play("frente")
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
		sprite.play("ataque lado")
		if direcao.x <0:
			sprite.flip_h = true
			sprite.offset.x = -3
		else:
			sprite.flip_h = false
			sprite.offset.x = 0
	else:
		sprite.flip_h = false
		sprite.offset.x = 0
		if direcao.y <0:
			sprite.play("ataque costas")
		else:
			sprite.play("ataque frente")
	await sprite.animation_finished
	var projetil : Projetil = PROJETIL_INIMIGO_MULTA.instantiate()
	get_tree().current_scene.add_child(projetil)
	#guardaProjetil.add_child(projetil)
	projetil.global_position = global_position + direcao * 16
	projetil.lancar(velocidadeProjetil, direcao)
	cooldownAtaque.start()
	atacando = false
