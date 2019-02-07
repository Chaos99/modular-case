// create main enclosure
module shell(diameter, height, wall_thickness, base){
	translate([0, 0, height/2])
		difference() {
			cylinder(h = height, d = diameter, center = true);
				if (base) // remove core, keep bottom
					translate([0,0,wall_thickness])
						cylinder(h = height, d = diameter-wall_thickness*2, center = true);
				else // remove core, no bottom
					cylinder(h = height+1, d = diameter-wall_thickness*2, center = true);
		}
}

// connectors to receive another module on top
// these are placed 10deg off-center -> counterparts should be placed -10deg off center
module connectors_female(angle, base_radius, height, wall_thickness) {
	width = 10; // in degrees	
	rotate([0,0,angle])
	    intersection(){ // only needed for openscad <2018 
			//rotate_extrude(angle = width, $fn = 200) // works in openscad >2018
			rotate_extrude($fn = 200) // works in openscad <2018 incl. thingieverse
				translate([-base_radius + wall_thickness, height-5.7]) //0.3 to center scaled male pin
					polygon(
						points = [[0,0],[0,12],[1,15],[6.8,15],[6.8,5],[1.8,0], [1.5,5.7],[1.5,5.7+3.8],[1.5+2.5,5.7+6.3],[1.5+4.5,5.7+6.3],[1.5+4.5,5.7]],
						paths = [[0,1,2,3,4,5], [6,7,8,9,10,11]]
					);
		// only needed for openscad <2018
			translate([-3*base_radius,0,height-5.7])
				cube([3*base_radius,width,13]);			
		}
}

// connectors to connect to another module below
module connectors_male(angle, base_radius, wall_thickness) {
	width = 15; // in degrees for openscad >2018 / in mm for openscad <2018
	//pin
	rotate([0,0,angle]) {  
		intersection(){ // only needed for openscad <2018
			//rotate_extrude(angle = width, $fn = 200)  // works in openscad >2018
			rotate_extrude($fn = 200) // works in openscad <2018 incl. thingieverse
				translate([-base_radius + wall_thickness, -5.7 ])
					translate([0.45,0]) // counteract the non-centered scale (but leave flat on build plate)
						scale([0.85,0.955]) // scale to leave room for easier connection (=-[0.9,0.9]mm)
							polygon(
								points = [[1.5,5.7],[1.5,9.5],[4,12],[6,12],[6,5.7]],
								paths = [[0,1,2,3,4,5]]
							);
			// only needed for openscad <2018
			translate([-3*base_radius,0,0])
				cube([3*base_radius,width,13]);
		}
	}

	// pin-base
	rotate([0,0,angle])
		intersection(){ // only needed for openscad <2018
			//rotate_extrude(angle = width, $fn = 200) // works in openscad >2018
			rotate_extrude($fn = 200) // works in openscad <2018 incl. thingieverse
				translate([-base_radius + wall_thickness, -5.7])
					polygon(
						points = [[0,5.7],[0,12],[1,15],[6,15],[6,5.7],[1.8,5.7]],
						paths = [[0,1,2,3,4,5]]
					);
			// only needed for openscad <2018
			translate([-3*base_radius, -width*0.8, 0]) // arbitrarily scalled to 80% width
				cube([3*base_radius, width*0.8, 13]);
		}
}

// adds a sensor enclosure to the module
// parameters are length/width of enclosure
module enclosure(angle, length, width, base_radius, base_height, wall_thickness, port_radius) {
	difference() {
		difference() {
			translate([base_radius-length-wall_thickness,-width/2,0])
				difference() {
					cube([length, width, base_height], false);
					translate([wall_thickness,wall_thickness,wall_thickness])
						cube([length, width-wall_thickness*2, base_height-wall_thickness+1], false);
				}

			// wiring hole
			translate([base_radius-length-wall_thickness-1, 0, base_height/2+wall_thickness/2])
				rotate([0,90,0])
					cylinder(wall_thickness+2, r = port_radius);
		}

		// make sure we don't exceed the outer shell
		difference() {
			cylinder(h = base_height * 4, d = base_radius * 2.5, center = true);
			cylinder(h = base_height * 4 + 2, d = base_radius * 2, center = true);
		}
	}
};


// example renders
connectors_female(90, 60, 40, 5);
connectors_male(90, 60, 5);