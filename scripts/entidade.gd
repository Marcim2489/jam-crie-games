extends CharacterBody2D
class_name Entidade

@export var velocidadeMovimento : int = 100
@export var hurtbox : Hurtbox
@export var guardaProjetil : Node

func _ready() -> void:
	if(hurtbox != null):
		hurtbox.morreu.connect(morrer)

func morrer():
	call_deferred("queue_free")
