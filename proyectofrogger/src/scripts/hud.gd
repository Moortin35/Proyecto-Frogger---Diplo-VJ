extends CanvasLayer

class_name Hud

@onready var vidas: HBoxContainer = %vidas
#menu tras terminar partida
@onready var center_container: CenterContainer = %CenterContainer
@onready var panel_container: PanelContainer = %PanelContainer
@onready var resultado: Label = %resultado


var texture_vida = preload("res://_assets/heart.png")
var texturas_vidas: Array[TextureRect] = []

func crear_vidas(cantidad_vidas: int):
	for i in cantidad_vidas:
		var texture_rect = TextureRect.new()
		texture_rect.custom_minimum_size = Vector2(16,16)
		texture_rect.texture = texture_vida
		texture_rect.texture_filter = TextureRect.TEXTURE_FILTER_NEAREST
		vidas.add_child(texture_rect)
		texturas_vidas.append(texture_rect)

func mostrar_perder():
	resultado.text = "PERDISTE, te desmayaste en la nieve"
	center_container.show()
	
func mostrar_ganar():
	resultado.text = "GANASTE, rescataste a las calico"
	center_container.show()


func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func perder_vidas():
	#eliminamos un elemento del arreglo de texturas vidas
	var _textura_vida = texturas_vidas.pop_back()
	#liberamos el contenido
	_textura_vida.queue_free()
