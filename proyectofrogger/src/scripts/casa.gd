extends Area2D

class_name Casa

signal entro_casa

@onready var obtención: Sprite2D = $obtención


func _on_area_entered(area: Area2D) -> void:
	if area is Jugador:
		entro_casa.emit()
		obtención.show()
