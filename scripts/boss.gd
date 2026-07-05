extends Entidade
class_name Boss

const PROJETIL_BOSS_XINGO = preload("uid://cng72e2buexmu")
@export var hitboxCollision : CollisionShape2D
@export var maoHitboxCollision : CollisionShape2D
@export var mao : Node2D
@export var eixo : Node2D
@export var animPlayer : AnimationPlayer
@export var cooldownTimer : Timer
@export var statesKeeper : BossStatesKeeper
@export var velocidadeProjetil : int = 180
@export var lifeBar : ProgressBar

var morto : bool = false
var player : Player

var repetidos : int = 0
var ultimoAtaqueTapa : bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	if(hurtbox != null):
		hurtbox.morreu.connect(morrer)
		hurtbox.recebeuDano.connect(aoReceberDano)
	for state : BossState in statesKeeper.states:
		state.boss = self
	eixo.visible = false
	statesKeeper.currentState = statesKeeper.states[0]
	statesKeeper.changeState(statesKeeper.states[0])

func _process(delta: float) -> void:
	statesKeeper.update(delta)
	move_and_slide()

func getPlayerDirection() -> Vector2:
	var direction = (player.global_position - global_position).normalized()
	return direction

func getPlayerAproxDirection()-> Vector2:
	var direction = getPlayerDirection()
	var xabs : float = direction.x
	var yabs : float = direction.y
	if xabs < 0:
		xabs *= -1
	if yabs < 0:
		yabs *= -1
	if xabs >= yabs:
		direction.y = 0
	else:
		direction.x = 0
	if direction.x > 0:
		return Vector2.RIGHT
	if direction.x < 0:
		return Vector2.LEFT
	if direction.y > 0:
		return Vector2.DOWN
	if direction.y < 0:
		return Vector2.UP
	return direction

func getPlayerDistance() -> float:
	return (player.global_position - global_position).length()

func lancarXingo():
	var xingo : Projetil = PROJETIL_BOSS_XINGO.instantiate()
	get_tree().current_scene.add_child(xingo)
	var direcao : Vector2 = getPlayerDirection()
	xingo.global_position = (global_position + 
	direcao*16)
	xingo.lancar(velocidadeProjetil, direcao)

func darTapa():
	mao.look_at(player.global_position)
	animPlayer.play("tapa")

func morrer():
	if morto:
		return
	morto = true
	lifeBar.visible = false
	velocity = Vector2.ZERO
	statesKeeper.changeState(statesKeeper.states[3])
	sprite.play(["calmo veio", "calmo veia"].pick_random())
	hitboxCollision.set_deferred("disabled", true)
	animPlayer.call_deferred("stop")
	mao.call_deferred("queue_free")
	hurtbox.set_deferred("monitoring", false)
	hurtbox.set_deferred("monitorable", false)
	guardaProjetil.call_deferred("queue_free")
	player.derrotouBoss()
	morreu.emit()
