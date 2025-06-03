extends Node

@onready var jugador: Jugador = $"../jugador"

func matar_jugador():
	print("[MUERE JUGADOR]")
	jugador.muere()
