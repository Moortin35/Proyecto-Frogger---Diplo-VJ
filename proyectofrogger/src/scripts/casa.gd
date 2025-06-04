extends Area2D

class_name Casa

signal entro_casa

@onready var obtención: Sprite2D = $obtención
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_area_entered(area: Area2D) -> void:
	if area is Jugador:
		entro_casa.emit()
		obtención.show()
		collision_shape_2d.set_deferred("disabled", true)
