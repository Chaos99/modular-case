// Unfortunately, customizable parameters have to be in the main file, although
// they are used in the libraries

/* [PCB Dimensions] */

// width of a PCB
board_width = 26; //[18:Ardino_nano, 23:Feather_HUZZAH, 26:NodeMCUv2, 31:NodeMCUv3, 53.3:Ardunio_Mega, 53.4:Arduino_Uno]

// length of a PCB
board_length = 48; //[45:Arduino_nano, 48:NodeMCUv2, 51:NodeMCUv3, 51:Feather_HUZZAH, 68.6:Arduino_Uno, 101.52:Ardunio_Mega]


/* [Case Dimensions] */

// diameter of the base
base_diameter = 62.8; //[62.8:Small, 80:Medium, 100:Large, 130:XLarge]

// thickness of outer wall
wall_thickness = 3; //[2:1:5]

// height of the base
base_height = 28.6; //[20:5:100]

/* [Access Port Dimensions] */

// width of the port hole for e.g. USB access
port_width = 15; //[5:1:50]

// height of the port hole for e.g. USB access
port_height = 5; //[4:1:30]

/* [Empty Module] */

// create an empty module
create_empty = true;

// height of the empty module
empty_height = 30; // [10:1:60]


/* [Hidden] */

$fn=256;

base_radius = base_diameter / 2;


include <base.scad>
include <empty.scad>


union(){
	base(base_radius, base_height, wall_thickness, board_length, board_width, port_width, port_height);
	if (create_empty)
		translate([0,0,base_height]) empty(base_radius, empty_height, wall_thickness);
}
