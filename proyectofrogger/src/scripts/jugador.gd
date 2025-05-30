extends Area2D

class_name Jugador

const INCREMENTO_POSICION = 16
@export var velocidad = 35
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var nueva_posicion: Vector2  = Vector2.ZERO

func _process(delta: float) -> void:
	if nueva_posicion == Vector2.ZERO:
		return
		
	position = lerp(position, nueva_posicion, velocidad * delta) 
	
	if position.distance_to(nueva_posicion) < 0.1:
		position = nueva_posicion
		nueva_posicion = Vector2.ZERO
		animated_sprite_2d.play("idle")
		 

func _input(event: InputEvent) -> void:
	if nueva_posicion != Vector2.ZERO:
		return
		
	var posicion_modificada
	
	if event.is_action_pressed("up"):
		posicion_modificada = position + Vector2.UP * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")

	elif event.is_action_pressed("down"):
		posicion_modificada = position + Vector2.DOWN * INCREMENTO_POSICION
		animated_sprite_2d.play("moving")
		
	elif event.is_action_pressed("left"):
		posicion_modificada = position + Vector2.LEFT * INCREMENTO_POSICION
		animated_sprite_2d.set_flip_h(true)
		animated_sprite_2d.play("moving")
		
	elif event.is_action_pressed("right"):
		posicion_modificada = position + Vector2.RIGHT * INCREMENTO_POSICION
		animated_sprite_2d.set_flip_h(false)
		animated_sprite_2d.play("moving")
		

	if posicion_modificada:
		mover_jugador(posicion_modificada)
		
func mover_jugador(posicion_modificada: Vector2) -> void:
	var tile_offset = 8
	var viewport_size = get_viewport_rect().size
	var min_x = tile_offset
	var max_x = viewport_size.x - tile_offset
	var min_y = tile_offset
	var max_y = viewport_size.y - tile_offset
	
	var posicion_campleada = Vector2(
		clamp(posicion_modificada.x, min_x, max_x),
		clamp(posicion_modificada.y, min_y, max_y)
	)	
	nueva_posicion = posicion_campleada
