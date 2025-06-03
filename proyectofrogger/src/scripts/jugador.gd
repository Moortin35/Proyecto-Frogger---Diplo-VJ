extends Area2D

#le damos un nombre de clase a este script para poder referenciarlo desde otros lugares
class_name Jugador

signal vida_perdida

#constante que define cuánto se moverá el jugador en cada paso (16 píxeles)
const INCREMENTO_POSICION = 16
#constante de posicion inicial del jugador
const POSICION_INICIAL_JUGADOR = Vector2(152.0, 200.0)

#referencia al componentes de jugador
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

#variable que controla la velocidad de movimiento
#(exportada para poder modificarla en el editor)
@export var velocidad = 35
@export var vidas = 3

#variable para almacenar la posición a la que queremos mover al jugador
var nueva_posicion: Vector2  = Vector2.ZERO

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	print("[PERDIO VIDA]")
	vida_perdida.emit()
	vidas -= 1
	if vidas == 0:
		set_process_input(false)
		print("JUEGO TERMINADO", vidas)
	else:
		print("VIDAS RESTANTES: ", vidas)
		resetear_jugador()
	
	
#función que Godot ejecuta automáticamente en cada fotograma (delta es el tiempo entre fotogramas)
func _process(delta: float) -> void:
	#si no hay una nueva posición asignada, no hacemos nada
	if nueva_posicion == Vector2.ZERO:
		return
	
	#mueve suavemente (interpola) la posición actual hacia la nueva posición
	position = lerp(position, nueva_posicion, velocidad * delta) 
	
	#si estamos muy cerca de la nueva posición (a menos de 0.1 píxeles)
	if position.distance_to(nueva_posicion) < 0.1:
		#ajustamos exactamente a la nueva posición
		position = nueva_posicion
		#reseteamos la nueva posición a ZERO (indicando que ya llegamos)
		nueva_posicion = Vector2.ZERO
		#reproducimos la animación "idle" (quieto)
		animated_sprite_2d.play("idle")


#función que Godot ejecuta automáticamente cuando hay entrada del usuario
func _input(event: InputEvent) -> void:
	#si ya estamos moviéndonos hacia una nueva posición, ignoramos nuevas entradas
	if nueva_posicion != Vector2.ZERO:
		return
	
	#variable para guardar la posición modificada por la entrada del usuario	
	var posicion_modificada
	
	if event.is_action_pressed("up"):
		#calculamos nueva posición sumando 16 píxeles hacia arriba
		posicion_modificada = position + Vector2.UP * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")
	
	elif event.is_action_pressed("down"):
		posicion_modificada = position + Vector2.DOWN * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")
		
	elif event.is_action_pressed("left"):
		posicion_modificada = position + Vector2.LEFT * INCREMENTO_POSICION
		#volteamos el sprite horizontalmente (para que mire a la izquierda)
		animated_sprite_2d.set_flip_h(true)
		animated_sprite_2d.play("moving")
		
	elif event.is_action_pressed("right"):
		posicion_modificada = position + Vector2.RIGHT * INCREMENTO_POSICION
		#aseguramos que el sprite no esté volteado (mire a la derecha)
		animated_sprite_2d.set_flip_h(false)
		animated_sprite_2d.play("moving")
		
	#si se calculó una nueva posición modificada (por alguna tecla presionada)
	if posicion_modificada:
		#llamamos a la función para mover al jugador
		mover_jugador(posicion_modificada)


#función para mover al jugador a una nueva posición, asegurándose que no salga de la pantalla
func mover_jugador(posicion_modificada: Vector2) -> void:
	#margen de 8 píxeles para que el jugador no se salga completamente de la pantalla
	var tile_offset = 8
	#obtenemos el tamaño de la pantalla/pantalla de juego
	var viewport_size = get_viewport_rect().size
	#calculamos los límites donde puede moverse el jugador:
	var min_x = tile_offset #límite izquierdo
	var max_x = viewport_size.x - tile_offset #límite derecho
	var min_y = tile_offset #límite superior
	var max_y = viewport_size.y - tile_offset #límite inferior
	
	#aseguramos que la nueva posición esté dentro de los límites calculados
	var posicion_campleada = Vector2(
		clamp(posicion_modificada.x, min_x, max_x), #limita coordenada X
		clamp(posicion_modificada.y, min_y, max_y) #limita coordenada Y
	)
	#asignamos la posición limitada como nuestro nuevo destino	
	nueva_posicion = posicion_campleada

func muere():
	if vidas > 0:
		#en el primer momento o frame que tenga libre el jugador, que haga tal acción
		#en este caso desactivo la colision
		collision_shape_2d.set_deferred("disabled", true)
		#cuando ocurré este evento cambia la animación
		animated_sprite_2d.play("hit")
		#al morir queda deshabilitado el input
		set_process_input(false)
		timer.start()


func resetear_jugador():
	set_process_input(true)
	collision_shape_2d.set_deferred("disabled", false)
	animated_sprite_2d.play("idle")
	global_position = POSICION_INICIAL_JUGADOR
	nueva_posicion = POSICION_INICIAL_JUGADOR
