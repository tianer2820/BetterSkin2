extends Node


# action ids
enum Action{
	FILE_NEW,
	FILE_OPEN,
	FILE_SAVE,
	FILE_CLOSE,
	
	UNDO,
	REDO,
	
	SEL_ALL,
	SEL_NONE,
}