extends Node


# action ids
enum Action{
	FILE_NEW,
	FILE_OPEN,
	FILE_SAVE,
	FILE_CLOSE,
	FILE_IMPORT,
	FILE_EXPORT,
	
	UNDO,
	REDO,
	
	SEL_ALL,
	SEL_NONE,
}

const GLOBAL_DIALOG_ROOT = "/root/GUIRoot/GlobalDialogs/"
const EXPORT_PNG_DIALOG = GLOBAL_DIALOG_ROOT + "ExportPNGDialog"
const IMPORT_PNG_DIALOG = GLOBAL_DIALOG_ROOT + "ImportPNGDialog"
