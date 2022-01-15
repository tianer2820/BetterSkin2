extends Reference
class_name SkinRegion

"""
A data class, defines a region in the skin document, e.g. head front, body top, left leg left side, etc.

Region is defined on 64x64 skin size, scalling for other resolution is done by functions using this data, not by this class. So for any skin size, the region data should always be the same, assuming skin size of 64x64

Unit is pixels
"""

var name: String = ""
var rect: Rect2 = Rect2(0, 0, 0, 0)
