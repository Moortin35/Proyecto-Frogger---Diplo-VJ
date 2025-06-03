extends Node

@onready var jugador: Jugador = $"../jugador"

func matar_jugador():
	print("[SE MUERE]")
	jugador.muere()
