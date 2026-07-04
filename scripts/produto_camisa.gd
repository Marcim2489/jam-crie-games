extends Produto

var defesaExtra : int = 3

func aplicarEfeito(player : Player):
	player.hurtbox.defesa += defesaExtra

func retirarEfeito(player : Player):
	player.hurtbox.defesa -= defesaExtra
