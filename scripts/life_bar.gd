extends ProgressBar

@export var source : Hurtbox

func _ready() -> void:
	source.mudouVida.connect(atualizarDisplay)
	atualizarDisplay(source.vidaAtual, source.vidaMaxima)

func atualizarDisplay(vidaAtual : int, vidaMaxima: int):
	max_value = vidaMaxima
	value = vidaAtual
