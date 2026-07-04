extends CharacterBody2D
class_name Entidade

@export var velocidadeMovimento : int = 100
@export var hurtbox : Hurtbox
@export var guardaProjetil : Node
@export var sprite : AnimatedSprite2D
@export var timerDano : Timer
signal morreu

func _ready() -> void:
	if(hurtbox != null):
		hurtbox.morreu.connect(morrer)
		hurtbox.recebeuDano.connect(aoReceberDano)

func aoReceberDano():
	sprite.self_modulate.g = 0
	sprite.self_modulate.b = 0
	sprite.self_modulate.r = 0.7
	#sprite.self_modulate.a = 0.6
	timerDano.start(0.1)
	await timerDano.timeout
	sprite.self_modulate.g = 1
	sprite.self_modulate.b = 1
	sprite.self_modulate.r = 1

func morrer():
	morreu.emit()
	call_deferred("queue_free")
