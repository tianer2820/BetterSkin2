# Coding Styles

This documents some convension to follow when writting this project.
Most of these are the same as the convension suggested on godot.org

## Naming

Code naming:
```
class_name ClassName

func func_name(params)
func _private_func_name(params)
func _on_ObjectName_signal_name(params)

var variable_name
var _private_variable_name
```

Objects in scene tree:
`ObjectName`

File name:
```
file_name.gd
file_name.xxx
```

## Code documenting
Add one or multiple line of comments before the code line:
```
# one line of comment
func useful_function():
    pass

"""many lines
of comment"""
func useful_function():
    pass
```

Add comments for classes after the `extends` or `class_name` line:
```
extends node

"""detailed documentation for this class
add more lines if needed"""

var a

func my_func():
    pass
```


## File structures
Put related files together, regardless of their type.

example:
- res://
    - assets
        - player
            - player.tscn
            - player.gd
            - player_icon.png
            - player_animation.png
            - and more
        - enemy
            - enemy.tscn
            - enemy.gd
            - and more
    - scripts
        - global_system_1.gd
        - complex_global_system
            - component_1.gd
            - component_2.gd
        - data_class_1.gd
    - data
        - data_file_1.txt
        - data_file_2.json


## Signal/Calling

- Use AutoLoad for singleton classes, call them from anywhere.
- Call down, signal up.
- Modulize as much as possible. Require nothing from parent nodes.
- Add an explicate name for data classes using `class_name`
- throw errors using `assert(false, "message")`. don't just `pass`
