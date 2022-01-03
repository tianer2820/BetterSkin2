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

### Middle
- move all constants to CST class
- reimplement color picker signal structure to match other parts of the program
- implement all tool properties panels
- implement 3D to UV mapping, 3D viewport pen input
- implement layer viewer add/delete layer function
- implement settings manager
- implement select&move tool
- add color palette, color mix/gradient generator, palette from image/palette to image, fill with palette etc.
- add region in skins, region fill, auto shadows, mirror, region select etc.
- add noise
- region clip option for pen tool
- add pose function, make 3D model a separate asset with internal functions and simple interface
- add grid on 3D
- add support for custom shortcut keys for tool switching & quick tools

### Simple
- new icon
- new theme
- implement HSV color selector
- implement color mixer
- add eraser tool
- add pen tool
- rewrite program interface to match the style of the DocumentManager
- add all skin overlay texts
- let 2d camera scale around mouse instead of screen center
- shortcut to add color to palette, increase/decrease brightness, previous/next pallete

### Currently working on:
- add eraser tool
- regions and skin formats