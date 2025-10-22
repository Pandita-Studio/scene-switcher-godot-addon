## Scene Switcher (Godot 4 Addon)

Lightweight scene transition helper for Godot 4.x that adds a global autoload called `SceneSwitcher` to perform smooth fade-to-black scene changes. It also fades in from black on startup. Includes a minimal example with two scenes you can switch between.

---

## Summary

- Provides a single global API: `SceneSwitcher.switch_to("res://path/to/Scene.tscn")`
- Smooth fade-in/out using a full-screen ColorRect overlay
- Configurable fade duration and transition delay via Project Settings
- Ships with example scenes under `scenes/` showing typical usage

---

## What it does

When the plugin is enabled, it registers an autoload singleton named `SceneSwitcher` (class `SceneSwitcherHandler`). At runtime, it automatically adds a full-screen overlay (a CanvasLayer with a ColorRect) that:

- On game start: waits a short delay, then fades out from black
- On scene switch: fades to black, changes the scene, waits a short delay, and fades out again

This produces a simple, consistent transition effect for any scene change with one line of code.

---

## Installation

1. Copy the `addons/sceneswitcher` folder into your project.
2. In Godot, open Project > Project Settings > Plugins and enable “sceneswitcher”.
3. The plugin will register the `SceneSwitcher` autoload and add two configurable Project Settings entries (see below).

Requirements: Godot 4.x.

---

## Configuration

You can tweak the transition behavior via Project Settings (General):

- `plugins/scene_swicther/fade_duration` (float, default: `0.5`)
	- How long the fade in/out animation takes (seconds).
- `plugins/scene_swicther/transition_delay` (float, default: `2.0`)
	- Extra delay before fading out on startup and between fade-in and fade-out during a scene switch (seconds).

Note: the category path uses the key `scene_swicther` as defined by the plugin.

---

## Usage

Call the global `SceneSwitcher` from any script to change scenes with a fade:

```gdscript
# Switch to another scene with a fade-to-black transition
SceneSwitcher.switch_to("res://scenes/second_scene/SecondScene.tscn")
```

If you need to know when the transition is fully done, you can await the `finished` signal:

```gdscript
await SceneSwitcher.finished
# Safe to proceed after the fade-out completes
```

Behavior details:

- The plugin adds its overlay at runtime (not in the editor). On startup it waits `transition_delay`, then fades out from black.
- `switch_to(path)` asserts in debug if the scene file doesn’t exist or if `change_scene_to_file` fails. Provide a valid `.tscn` path.

---

## API Reference

Autoload: `SceneSwitcher` (class `SceneSwitcherHandler`)

- Signals
	- `finished` — Emitted after a startup fade-out or after a full switch (fade-in, change scene, delay, fade-out).

- Methods
	- `switch_to(p_scene_path: String) -> void` — Fades to black, changes the scene to `p_scene_path`, waits `transition_delay`, fades out, then emits `finished`.

Overlay: `SceneSwitcherBlackRect`

- A `CanvasLayer` with a `ColorRect` child used to animate the fade. You’ll find it at `res://addons/sceneswitcher/nodes/blackrect/black_rect.tscn`.
- By default it’s opaque black; you can adjust the color in that scene if desired.

---

## Example scenes included

Two example scenes in this repo show minimal usage:

- `scenes/first_scene/FirstScene.tscn` with script `first_scene.gd`
- `scenes/second_scene/SecondScene.tscn` with script `second_scene.gd`

Each scene has a button that calls `SceneSwitcher.switch_to(...)` to navigate to the other scene. Run the project and press the button to see the fade transition in action.

---

## How it works (under the hood)

- The plugin registers an autoload singleton (`SceneSwitcher`) and, at runtime, defers adding a `SceneSwitcherBlackRect` CanvasLayer to the root viewport.
- Fades are performed using tweens on the `ColorRect`’s alpha channel.
- Startup sequence: wait `transition_delay` → fade out from black → emit `finished`.
- Switch sequence: fade to black → `change_scene_to_file(path)` → wait `transition_delay` → fade out → emit `finished`.

---

## Notes and caveats

- The transition delay happens on startup and between the fade-in and fade-out of a scene switch. Adjust it in Project Settings to fit your UX.
- The `assert` checks are active in debug builds. In release, ensure your scene paths are correct.
- The overlay is added only when running the game (not while editing scenes).

---

## Contributing

Issues and pull requests are welcome. If you propose a change to behavior or default settings, please include a brief rationale and, if possible, an example.

---

## License

MIT License — see the [`LICENSE`](./LICENSE) file for details.

