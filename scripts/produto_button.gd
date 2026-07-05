extends Button

@export var descricao : String

signal olhando (descricao : String)

func _ready() -> void:
	mouse_entered.connect(mouseEntrou)
	SalaManager.verBotoes.connect(habilitarVisual)
	habilitarVisual(false)

func _process(_delta: float) -> void:
	release_focus()

func habilitarVisual(enable : bool):
	visible = enable

func mouseEntrou():
	olhando.emit(descricao)

func conectarFuncoes(player : Player):
	olhando.connect(player.mudarDescricao)
	mouse_exited.connect(player.tirarDescricao)
