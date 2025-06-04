extends Node

@onready var jugador: Jugador = $"../jugador" as Jugador
@onready var casas_manager: Node = $"../casas_manager" as CasasManager
@onready var hud: Hud = $"../hud"


func _ready() -> void:
	casas_manager.todas_las_casas_tomadas.connect(on_todas_las_casas_tomadas)
	casas_manager.casa_tomada.connect(on_casa_tomada)
	hud.crear_vidas(jugador.vidas)
	jugador.vida_perdida.connect(on_vida_perdida)
	jugador.game_over.connect(on_game_over)


func on_casa_tomada():
	print("{en_casa_tomada}")
	jugador.resetear_jugador()

func on_todas_las_casas_tomadas():
	jugador.resetear_jugador()
	jugador.set_process_input(false)
	print("[GANASTE EL JUEGO]")
	hud.mostrar_ganar()

func on_vida_perdida():
	hud.perder_vidas()

func matar_jugador():
	print("[SE MUERE]")
	jugador.muere()

func on_game_over():
	hud.mostrar_perder()
