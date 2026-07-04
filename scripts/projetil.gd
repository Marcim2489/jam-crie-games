extends CharacterBody2D
class_name Projetil

@export var lifeTimer : Timer
@export var detectorCenario : Area2D
@export var hitbox : Hitbox
@export var penetracao : int = 2
var inimigosAtingidos : int = 0

func _ready() -> void:
	if lifeTimer != null:
		lifeTimer.timeout.connect(finalizarVida)
	if detectorCenario != null:
		detectorCenario.body_entered.connect(bodyEntered)
		detectorCenario.area_entered.connect(areaEntered)
	if hitbox:
		hitbox.atingiu.connect(aoAtingir)

func aoAtingir():
	inimigosAtingidos += 1
	if(inimigosAtingidos >= penetracao):
		finalizarVida()

func _process(_delta: float) -> void:
	move_and_slide()

func lancar(velocidade: int, direcao : Vector2):
	velocity = velocidade * direcao
	look_at(global_position + 10*direcao)

func bodyEntered(body: Node2D):
	if body is Entidade:
		return
	finalizarVida()

func areaEntered(area : Area2D):
	if area is Hurtbox:
		return
	finalizarVida()

func finalizarVida():
	call_deferred("queue_free")
