extends Node2D
#Le doy nombre a mi nodo para referenciarlo o reconocerlo como un nodo objeto
class_name  LineaObstaculoOpuesto
#creo una señal para que cuando ocurra un evento lo podamos controlar,
#en este caso cuando hay contacto del objeto jugador con el obstaculo
signal jugador_golpeado

@onready var escena_obstaculo: PackedScene = preload("res://src/escenas/obstaculo.tscn")
#creo un onready para que cuando carguemos el script, nos cargue nuestra escena del obstaculo.

#variables a manipular para poder variar la cantidad y velocidad de los obstaculos
@export var contador_obstaculos = 3
@export var distancia_entre_obstaculos = 128
@export var velocidad = -200
@export var limite_movimiento_x = 304

#inicializacion de arreglo de obstaculos
var obstaculos = []

func _ready() -> void:
	for i in contador_obstaculos:
		#vamos a guardar nuestra escena de obstaculo(sprite, collision) en var obstaculo
		var obstaculo = escena_obstaculo.instantiate()
		#generacion de obstaculos, empiezan a la derecha y se generan hacia la izquierda
		obstaculo.position = Vector2(limite_movimiento_x + distancia_entre_obstaculos * i, 0)
		#cuando los dos objetos entran colision, se llama a la funcion de los parentesis
		obstaculo.area_entered.connect(on_jugador_entra_obstaculo)
		#agrego las instancias de obstaculo creados al arreglo obstaculo
		add_child(obstaculo)
		obstaculos.append(obstaculo)
		
func _process(delta: float) -> void:
	for obstaculo in obstaculos:
		#calcula la nueva posición en X multiplicando la velocidad por el tiempo delta
		#y sumándolo a la posición actual del obstáculo
		#la velocidad ahora es negativa (movimiento hacia la izquierda)
		var nueva_posicion_x = velocidad * delta + obstaculo.position.x
		#ahora si se pasa del borde izquierdo, reaparece a la derecha
		if nueva_posicion_x < -limite_movimiento_x:
			obstaculo.position.x = limite_movimiento_x
		else:
			#Si no ha llegado al límite, actualiza su posición normalmente
			obstaculo.position.x = nueva_posicion_x
		
func on_jugador_entra_obstaculo(area: Area2D):
	print("[GOLPEO JUGADOR]")
	#si el area de colision que detecta es el jugador, emite la señal
	if area is Jugador:
		jugador_golpeado.emit()
