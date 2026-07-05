extends Entidade
class_name Player

@export var ataqueCooldown : Timer
@export var velocidadeProjetil : int = 180
@export var projectileOffset : int = 10
@export var boneSprite : AnimatedSprite2D
@export var timerImunidade : Timer
@export var gradeProdutos : GridContainer
@export var hbox : HBoxContainer
@export var descricao : Label
@export var tocadorAudioAndar : AudioStreamPlayer2D
@export var tocadorAudioDano : AudioStreamPlayer2D

var direcao : Vector2 = Vector2.ZERO
var boomerangDisponivel : bool = true
const PROJETIL_PLAYER = preload("uid://c5t7hnfexwugc")
const PRODUTO_TENIS = preload("uid://cvnd1htea3goq")
const PRODUTO_CAMISA = preload("uid://dp4ch2rj6fate")
const PRODUTO_PIZZA = preload("uid://da0mak2ho48x7")

var hitsParaPerderProduto : int = 5
var hitsTomados : int = 0

var ganhouJogo : bool = false

enum Produtos {
	TENIS,
	PIZZA,
	CAMISA,
	GARRAFA
}

func _ready() -> void:
	if(hurtbox != null):
		hurtbox.morreu.connect(morrer)
		hurtbox.recebeuDano.connect(aoReceberDano)
	atualizarGrid()

func perderProduto():
	var produto : Produto = gradeProdutos.get_child(0)
	produto.retirarEfeito(self)
	produto.queue_free()
	if gradeProdutos.get_children().size() <= 1:
		hbox.visible = false

func atualizarGrid():
	if gradeProdutos.get_children().size() <= 0:
		hbox.visible = false
		return
	hbox.visible = true
	var i : int = 0
	while i < hbox.get_children().size():
		if i < 5- hitsTomados:
			hbox.get_child(i).color = Color.RED
		else: 
			hbox.get_child(i).color = Color.GRAY
		i+=1
func aoReceberDano():
	tocadorAudioDano.play()
	#print(gradeProdutos.get_children().size())
	if gradeProdutos.get_children().size() >=1:
		hitsTomados+=1
		if hitsTomados >= hitsParaPerderProduto:
			hitsTomados = 0
			perderProduto()
			atualizarGrid()
		else:
			atualizarGrid()
	else:
		atualizarGrid()
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
	if ganhouJogo:
		return
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
	if direcaoAtual != Vector2.ZERO and tocadorAudioAndar.playing==false:
		tocadorAudioAndar.play()
	elif direcaoAtual == Vector2.ZERO and tocadorAudioAndar.playing:
		tocadorAudioAndar.stop()
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
		var direcaoAtaque : Vector2 = (get_global_mouse_position() - 
		(global_position+Vector2.UP* 28)).normalized()
		var projetilInstancia : Boomerang = PROJETIL_PLAYER.instantiate()
		guardaProjetil.add_child(projetilInstancia)
		projetilInstancia.corpoLancador = self
		projetilInstancia.global_position = (global_position + 
		direcaoAtaque*projectileOffset +
		Vector2.UP* 28)
		projetilInstancia.lancar(velocidadeProjetil, direcaoAtaque)
		boomerangDisponivel = false
		boneSprite.visible = false

func boomerangVoltou():
	boomerangDisponivel = true
	boneSprite.visible = true

func coletarProduto(tipo : Produtos):
	var produto : Produto
	match tipo:
		Produtos.TENIS:
			produto = PRODUTO_TENIS.instantiate()
		Produtos.CAMISA:
			produto = PRODUTO_CAMISA.instantiate()
		Produtos.PIZZA:
			produto = PRODUTO_PIZZA.instantiate()
	gradeProdutos.add_child(produto)
	produto.aplicarEfeito(self)
	produto.get_child(0).conectarFuncoes(self)
	#produto.get_child(0).mouseEntrou.connect(mudarDescricao)
	#produto.get_child(0).mouse_exited.connect(tirarDescricao)
	atualizarGrid()

func derrotouBoss():
	ganhouJogo = true
	velocity = Vector2.ZERO
	sprite.play("win")
	SalaManager.produtosColetados = gradeProdutos.get_children().size()
	await sprite.animation_finished
	get_tree().call_deferred("change_scene_to_file", "res://cenas/victory_screen.tscn")


func mudarDescricao(desc : String):
	descricao.text = desc

func tirarDescricao():
	descricao.text = ""

func morrer():
	morreu.emit()
	boneSprite.visible = false
	hurtbox.set_deferred("monitoring", false)
	ganhouJogo = true
	velocity = Vector2.ZERO
	sprite.play("die")
	
	await sprite.animation_finished
	get_tree().call_deferred("change_scene_to_file", "res://cenas/game_over_screen.tscn")
