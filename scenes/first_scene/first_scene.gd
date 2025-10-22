extends Node2D


func _on_button_pressed() -> void:
	SceneSwitcher.switch_to("res://scenes/second_scene/SecondScene.tscn")
	print_debug("here")
