@tool
extends EditorPlugin

const SINGLETON_NAME = "SceneSwitcher"
const SINGLETON_PATH = "res://addons/sceneswitcher/sceneswitcher.gd"


func _enter_tree() -> void:
	add_autoload_singleton(SINGLETON_NAME, SINGLETON_PATH)
	
	if not ProjectSettings.has_setting(SceneSwitcherHandler.PROPERTY_NAME_FADE_DURATION):
		ProjectSettings.set_setting(SceneSwitcherHandler.PROPERTY_NAME_FADE_DURATION, 0.5)
		ProjectSettings.add_property_info({
			"name": SceneSwitcherHandler.PROPERTY_NAME_FADE_DURATION,
			"type": TYPE_FLOAT,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT
		})
		ProjectSettings.save()
	
	if not ProjectSettings.has_setting(SceneSwitcherHandler.PROPERTY_NAME_TRANSITION_DELAY):
		ProjectSettings.set_setting(SceneSwitcherHandler.PROPERTY_NAME_TRANSITION_DELAY, 2.0)
		ProjectSettings.add_property_info({
			"name": SceneSwitcherHandler.PROPERTY_NAME_TRANSITION_DELAY,
			"type": TYPE_FLOAT,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT
		})
		ProjectSettings.save()


func _exit_tree() -> void:
	remove_autoload_singleton(SINGLETON_NAME)
	ProjectSettings.clear(SceneSwitcherHandler.PROPERTY_NAME_FADE_DURATION)
	ProjectSettings.clear(SceneSwitcherHandler.PROPERTY_NAME_TRANSITION_DELAY)
