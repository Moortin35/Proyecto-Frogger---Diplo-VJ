extends Area2D

class_name Casa

signal entro_casa

@onready var casa_luna: AnimatedSprite2D = $casa_luna
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var efecto_sonido_luna: AudioStreamPlayer = $efecto_sonido_luna

func _ready() -> void:
	casa_luna.play("default")

func _on_area_entered(area: Area2D) -> void:
	if area is Jugador:
		entro_casa.emit()
		efecto_sonido_luna.play()
		casa_luna.hide()
		collision_shape_2d.set_deferred("disabled", true)
