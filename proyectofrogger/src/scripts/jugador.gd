extends Area2D

#Le damos un nombre de clase a este script para poder referenciarlo desde otros lugares
class_name Jugador

#Constante que define cuánto se moverá el jugador en cada paso (16 píxeles)
const INCREMENTO_POSICION = 16

#Variable que controla la velocidad de movimiento
#(exportada para poder modificarla en el editor)
@export var velocidad = 35

#Referencia al componente AnimatedSprite2D que está dentro de este nodo
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#Variable para almacenar la posición a la que queremos mover al jugador
var nueva_posicion: Vector2  = Vector2.ZERO

#Función que Godot ejecuta automáticamente en cada fotograma (delta es el tiempo entre fotogramas)
func _process(delta: float) -> void:
	#Si no hay una nueva posición asignada, no hacemos nada
	if nueva_posicion == Vector2.ZERO:
		return
	
	#Mueve suavemente (interpola) la posición actual hacia la nueva posición
	position = lerp(position, nueva_posicion, velocidad * delta) 

	#Si estamos muy cerca de la nueva posición (a menos de 0.1 píxeles)
	if position.distance_to(nueva_posicion) < 0.1:
		#Ajustamos exactamente a la nueva posición
		position = nueva_posicion
		#Reseteamos la nueva posición a ZERO (indicando que ya llegamos)
		nueva_posicion = Vector2.ZERO
		#Reproducimos la animación "idle" (quieto)
		animated_sprite_2d.play("idle")
		 
#Función que Godot ejecuta automáticamente cuando hay entrada del usuario (teclado, ratón, etc.)
func _input(event: InputEvent) -> void:
	#Si ya estamos moviéndonos hacia una nueva posición, ignoramos nuevas entradas
	if nueva_posicion != Vector2.ZERO:
		return
	
	#Variable para guardar la posición modificada por la entrada del usuario	
	var posicion_modificada
	
	if event.is_action_pressed("up"):
		#Calculamos nueva posición sumando 16 píxeles hacia arriba
		posicion_modificada = position + Vector2.UP * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")

	elif event.is_action_pressed("down"):
		posicion_modificada = position + Vector2.DOWN * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")
		
	elif event.is_action_pressed("left"):
		posicion_modificada = position + Vector2.LEFT * INCREMENTO_POSICION
		#Volteamos el sprite horizontalmente (para que mire a la izquierda)
		animated_sprite_2d.set_flip_h(true)
		animated_sprite_2d.play("moving")
		
	elif event.is_action_pressed("right"):
		posicion_modificada = position + Vector2.RIGHT * INCREMENTO_POSICION
		#Aseguramos que el sprite no esté volteado (mire a la derecha)
		animated_sprite_2d.set_flip_h(false)
		animated_sprite_2d.play("moving")
		
	#Si se calculó una nueva posición modificada (por alguna tecla presionada)
	if posicion_modificada:
		#Llamamos a la función para mover al jugador
		mover_jugador(posicion_modificada)
		
#Función para mover al jugador a una nueva posición, asegurándose que no salga de la pantalla
func mover_jugador(posicion_modificada: Vector2) -> void:
	#Margen de 8 píxeles para que el jugador no se salga completamente de la pantalla
	var tile_offset = 8
	#Obtenemos el tamaño de la pantalla/pantalla de juego
	var viewport_size = get_viewport_rect().size
	#Calculamos los límites donde puede moverse el jugador:
	var min_x = tile_offset # Límite izquierdo
	var max_x = viewport_size.x - tile_offset # Límite derecho
	var min_y = tile_offset # Límite superior
	var max_y = viewport_size.y - tile_offset # Límite inferior
	
	#Aseguramos que la nueva posición esté dentro de los límites calculados
	var posicion_campleada = Vector2(
		clamp(posicion_modificada.x, min_x, max_x), # Limita coordenada X
		clamp(posicion_modificada.y, min_y, max_y) # Limita coordenada Y
	)
	#Asignamos la posición limitada como nuestro nuevo destino	
	nueva_posicion = posicion_campleada
