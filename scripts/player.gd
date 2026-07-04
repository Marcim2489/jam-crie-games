extends Entidade
class_name Player

@export var ataqueCooldown : Timer
@export var velocidadeProjetil : int = 180
@export var projectileOffset : int = 10
@export var sprite : AnimatedSprite2D
@export var boneSprite : AnimatedSprite2D
@export var timerDano : Timer
@export var timerImunidade : Timer

var direcao : Vector2 = Vector2.ZERO
var boomerangDisponivel : bool = true
const PROJETIL_PLAYER = preload("uid://c5t7hnfexwugc")

func _ready() -> void:
	if(hurtbox != null):
		hurtbox.morreu.connect(morrer)
		hurtbox.recebeuDano.connect(aoReceberDano)

func aoReceberDano():
	sprite.self_modulate.g = 0
	sprite.self_modulate.b = 0
	sprite.self_modulate.r = 0.7
	#sprite.self_modulate.a = 0.6
	timerDano.start()
	await timerDano.timeout
	sprite.self_modulate.g = 0.7
	sprite.self_modulate.b = 0.7
	sprite.self_modulate.r = 0.7
	await timerImunidade.timeout
	sprite.self_modulate.g = 1
	sprite.self_modulate.b = 1
	sprite.self_modulate.r = 1
	#sprite.self_modulate.a = 1

func _process(_delta: float) -> void:
	var direcaoAtual : Vector2 = Vector2.ZERO
	if(Input.is_action_pressed("ui_right")):
		direcaoAtual.x +=1
	if(Input.is_action_pressed("ui_left")):
		direcaoAtual.x -=1
	if(Input.is_action_pressed("ui_down")):
		direcaoAtual.y +=1
	if(Input.is_action_pressed("ui_up")):
		direcaoAtual.y -=1
	direcaoAtual = direcaoAtual.normalized()
	velocity = velocidadeMovimento * direcaoAtual
	if direcao != direcaoAtual and direcaoAtual != Vector2.ZERO:
		direcao = direcaoAtual
	move_and_slide()
	if direcaoAtual == Vector2.ZERO:
		if direcao.x != 0:
			sprite.play("idle side")
			boneSprite.play("lado")
		if direcao.x > 0:
			sprite.flip_h = false
			boneSprite.flip_h = false
		elif direcao.x < 0:
			sprite.flip_h = true
			boneSprite.flip_h = true
		elif direcao.y > 0:
			sprite.play("idle front")
			boneSprite.play("frente")
			boneSprite.flip_h = true
		elif direcao.y < 0:
			sprite.play("idle back")
			boneSprite.play("costas")
			boneSprite.flip_h = false
	else:
		if direcao.x != 0:
			sprite.play("walk side")
			boneSprite.play("lado")
		if direcao.x > 0:
			sprite.flip_h = false
			boneSprite.flip_h = false
		elif direcao.x < 0:
			sprite.flip_h = true
			boneSprite.flip_h = true
		elif direcao.y > 0:
			sprite.play("walk front")
			boneSprite.play("frente")
			boneSprite.flip_h = true
		elif direcao.y < 0:
			sprite.play("walk back")
			boneSprite.play("costas")
			boneSprite.flip_h = false
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
		boneSprite.visible = false

func boomerangVoltou():
	boomerangDisponivel = true
	boneSprite.visible = true


func morrer():
	morreu.emit()
	get_tree().call_deferred("change_scene_to_file", "res://cenas/game_over_screen.tscn")
	#get_tree().change_scene_to_file("res://cenas/game_over_screen.tscn")
