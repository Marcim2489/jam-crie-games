extends Entidade
class_name Player

@export var ataqueCooldown : Timer
@export var velocidadeProjetil : int = 180
@export var projectileOffset : int = 10
var direcao : Vector2 = Vector2.ZERO
var boomerangDisponivel : bool = true
#const PROJETIL_PLAYER = preload("uid://dyofvx1o31s1q")
const PROJETIL_PLAYER = preload("uid://c5t7hnfexwugc")

func _process(_delta: float) -> void:
	direcao = Vector2.ZERO
	if(Input.is_action_pressed("ui_right")):
		direcao.x +=1
	if(Input.is_action_pressed("ui_left")):
		direcao.x -=1
	if(Input.is_action_pressed("ui_down")):
		direcao.y +=1
	if(Input.is_action_pressed("ui_up")):
		direcao.y -=1
	direcao = direcao.normalized()
	velocity = velocidadeMovimento * direcao
	move_and_slide()
	#if Input.is_action_pressed("ataque") and ataqueCooldown.is_stopped():
		#var direcaoAtaque : Vector2 = (get_global_mouse_position() - global_position).normalized()
		#var projetilInstancia : Projetil = PROJETIL_PLAYER.instantiate()
		#guardaProjetil.add_child(projetilInstancia)
		#projetilInstancia.global_position = global_position + direcaoAtaque*projectileOffset
		#projetilInstancia.lancar(velocidadeProjetil, direcaoAtaque)
		#ataqueCooldown.start()
	if Input.is_action_pressed("ataque") and boomerangDisponivel:
		var direcaoAtaque : Vector2 = (get_global_mouse_position() - global_position).normalized()
		var projetilInstancia : Boomerang = PROJETIL_PLAYER.instantiate()
		guardaProjetil.add_child(projetilInstancia)
		projetilInstancia.corpoLancador = self
		projetilInstancia.global_position = global_position + direcaoAtaque*projectileOffset
		projetilInstancia.lancar(velocidadeProjetil, direcaoAtaque)
		boomerangDisponivel = false

func boomerangVoltou():
	boomerangDisponivel = true
