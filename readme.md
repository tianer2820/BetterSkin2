# BetterSkin2
BetterSkin2 aims to be a feature-rich, customizable and easy-to-use Minecraft skin editor.

*BetterSkin is my previous c++ project, which is unfinished, so this project is called BetterSkin2*

**This project is not production ready yet**

## Why another skin editor
There are a lot of MC skin editor out there, but each of them have some issues including:
- Only available online
- Lack modern features that other drawing softwares provide
- Not customizable
- Some are not maintained anymore

Solving these problems is the primary goal of this project.

## Planned Features
**Main features**
- customizable pen tools
- convinient color picker
- supports layers
- reigon selections, copy/paste, transformation
- 3D view
- in-window reference images
- supports higher resolution

**Additional (less prioritized) features**
- switch camera mode
- grease pencil like blender
- advanced color mixer
- format converting
- filters/effects
- plugins
- paint custom models

## Contirbute
This projects is still in its very early stage, any api/structure may change, so no pull request will be accepted.

Contributions are welcomed after V1.0 is out, after the main architecture is fixed.


## TODOs
Below are some current todo list. Begin with some simple ones to become familiar with the project.

### Complex
- implement document open & save menu
- implement undo redo
- add pen buffer layer and pen indicator layer, reimplement render functions

### Middle
- move all constants to CST class
- reimplement color picker signal structure to match other parts of the program
- implement all tool properties panels
- implement 3D to UV mapping, 3D viewport pen input
- add support for replace layer mode, for adding tools like move or eraser, so layer buffer can be used either as a alpha over or as a replacement

### Simple
- new icon
- new theme
- implement HSV color selector
- implement color mixer
- add eraser tool
- add pen tool
- rewrite program interface to match the style of the DocumentManager
