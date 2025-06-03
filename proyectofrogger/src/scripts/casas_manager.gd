extends Node

class_name CasasManager

signal todas_las_casas_tomadas
signal casa_tomada

var contador_casas = 0
var casas_tomadas = 0

func _ready() -> void:
	var casas = get_children() as Array[Casa]
	contador_casas = casas.size()
	#voy a chequear constantemente en un for si se entro a alguna casa(si se emitio una señal)
	for casa in casas:
		casa.entro_casa.connect(on_jugador_entro_casa)

func on_jugador_entro_casa():
	print("[on_jugador_entro_casa]")
	casas_tomadas += 1
	casa_tomada.emit()
	
	if casas_tomadas == contador_casas:
		print("todas las casas han sido tomadas")
		todas_las_casas_tomadas.emit()
