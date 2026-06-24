# Arquivo game_over.gd
extends Control
# função que executa ao receber o sinal de botão clicado,
# enviando para a cena do jogo
func _on_tentar_novamente_button_pressed() -> void:
	GameManager.vidas = 3
	get_tree().change_scene_to_file("res://scenes/level.tscn")
