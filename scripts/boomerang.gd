extends Projetil
class_name Boomerang

@export var voltarTimer : Timer
@export var desaceleracao : int = 4000
@export var velocidadeMov : int = 60
@export var aceleracao : int = 5
var corpoLancador : Node2D
var comecouVolta : bool = false

func _ready() -> void:
	if lifeTimer != null:
		lifeTimer.timeout.connect(finalizarVida)
	if detectorCenario != null:
		detectorCenario.body_entered.connect(bodyEntered)
	SalaManager.mudouSala.connect(finalizarVida)
		#detectorCenario.area_entered.connect(areaEntered)
	#if hitbox:
		#hitbox.atingiu.connect(aoAtingir)

func lancar(velocidade: int, direcao : Vector2):
	velocity = velocidade * direcao
	velocidadeMov = velocidade
	look_at(global_position + 10*direcao)
	corpoLancador.morreu.connect(sumir)

func bodyEntered(body: Node2D):
	if body == corpoLancador and voltarTimer.is_stopped():
		#if body is Player:
			#body.boomerangVoltou()
		finalizarVida()

func sumir():
	call_deferred("queue_free")

func finalizarVida():
	if corpoLancador is Player:
		corpoLancador.boomerangVoltou()
	call_deferred("queue_free")

func aoAtingir():
	#inimigosAtingidos += 1
	#if(inimigosAtingidos >= penetracao):
		#finalizarVida()
	pass

func _process(delta: float) -> void:
	if(voltarTimer == null):
		move_and_slide()
		return;
	if voltarTimer.is_stopped():
		if comecouVolta == false:
			velocity = velocity.move_toward(Vector2.ZERO, delta* desaceleracao)
			if velocity.length() <= 1:
				velocity = Vector2.ZERO
				comecouVolta = true
		else:
			var direcao : Vector2 = (corpoLancador.global_position - 
			global_position).normalized()
			velocity = velocity.move_toward(direcao * velocidadeMov, delta* desaceleracao)
			velocidadeMov+=aceleracao
	move_and_slide()
