extends Button

@export var descricao : String

signal olhando (descricao : String)

func _ready() -> void:
	mouse_entered.connect(mouseEntrou)

func mouseEntrou():
	olhando.emit(descricao)

func conectarFuncoes(player : Player):
	olhando.connect(player.mudarDescricao)
	mouse_exited.connect(player.tirarDescricao)
