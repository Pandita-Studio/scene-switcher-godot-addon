@tool
extends EditorPlugin

const SINGLETON_NAME = "SceneSwitcher"
const SINGLETON_PATH = "res://addons/sceneswitcher/sceneswitcher.gd"


func _enter_tree() -> void:
	add_autoload_singleton(SINGLETON_NAME, SINGLETON_PATH)


func _exit_tree() -> void:
	remove_autoload_singleton(SINGLETON_NAME)
