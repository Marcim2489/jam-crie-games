extends Produto

var aumentoVelAtaque : int = 50

func aplicarEfeito(player : Player):
	player.velocidadeProjetil += aumentoVelAtaque

func retirarEfeito(player : Player):
	player.velocidadeProjetil -= aumentoVelAtaque
