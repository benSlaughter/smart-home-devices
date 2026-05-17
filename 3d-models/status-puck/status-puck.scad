// Status Puck Enclosure — OpenSCAD
// Circular dish with transparent PLA lid for LED diffusion
// Houses: Olimex ESP32-DevKit-Lipo Rev D + Adafruit NeoPixel Ring 12

/* === Parameters === */

// Overall dimensions
dish_outer_diameter = 80;       // Outer diameter of the dish
dish_wall_thickness = 3;        // Wall thickness (extra 1mm for lid lip)
dish_height = 25;               // Total dish height (without lid)
dish_inner_diameter = dish_outer_diameter - 2 * dish_wall_thickness;

// Lid
lid_height = 3;                 // Lid thickness (transparent PLA)
lid_tolerance = 0.3;            // Gap for press fit

// NeoPixel Ring 12
ring_outer_diameter = 37;       // Adafruit ring outer diameter
ring_inner_diameter = 23;       // Adafruit ring inner hole
ring_height = 3.5;              // Ring PCB thickness
ring_standoff_height = 15;      // Height to position ring near top

// ESP32 board (Olimex ESP32-DevKit-Lipo Rev D)
esp_length = 55;                // Board length
esp_width = 28;                 // Board width (between pin rows)
esp_total_width = 28;           // Width including headers
esp_height = 1.6;               // PCB thickness
esp_pin_length = 11;            // Length of pre-soldered header pins below PCB
esp_clearance = esp_pin_length + 1; // Height above floor for pin clearance

// USB cable exit
cable_slot_width = 12;          // Width for mini USB cable
cable_slot_height = 8;          // Height of slot

// Command strip area
strip_width = 20;               // Width of flat area on back
strip_length = 40;              // Length of flat area on back

$fn = 80;                       // Circle smoothness

/* === Modules === */

module dish_body() {
    difference() {
        // Outer cylinder
        cylinder(d=dish_outer_diameter, h=dish_height);
        
        // Hollow interior
        translate([0, 0, dish_wall_thickness])
            cylinder(d=dish_inner_diameter, h=dish_height);
        
        // Lid recess — cut a step into the top of the wall for the lid to sit in
        translate([0, 0, dish_height - lid_height])
            cylinder(d=dish_inner_diameter + 2 + lid_tolerance, h=lid_height + 1);
        
        // USB cable exit slot — at +X edge of dish wall, inline with ESP board
        translate([dish_outer_diameter/2 - dish_wall_thickness - 1, -cable_slot_width/2, dish_wall_thickness])
            cube([dish_wall_thickness + 2, cable_slot_width, cable_slot_height]);
    }
}

module ring_standoffs() {
    // 3 standoffs to hold the NeoPixel ring near the top
    // Positioned OUTSIDE the ESP32 footprint, near the dish wall
    standoff_diameter = 4;
    mount_radius = dish_inner_diameter/2 - standoff_diameter;
    
    // Place at 90, 210, 330 degrees to avoid the ESP board area and USB slot
    for (angle = [90, 210, 330]) {
        rotate([0, 0, angle])
            translate([mount_radius, 0, dish_wall_thickness])
                cylinder(d=standoff_diameter, h=ring_standoff_height);
    }
}

module esp_mount() {
    // Friction rail channels — the header pins slot into grooves
    // Board drops in from above, pins locate it precisely
    pin_row_spacing = 25.4;       // Distance between the two pin rows (centre to centre)
    channel_width = 3;            // Width of each channel (fits header pin row)
    channel_depth = esp_pin_length - 1; // Depth of channel (pins sit in but don't bottom out)
    board_length = esp_length;
    channel_tolerance = 0.3;
    
    // Two parallel channels in the floor of the dish
    // Board oriented along X axis, centred
    for (y_offset = [-pin_row_spacing/2, pin_row_spacing/2]) {
        translate([-board_length/2, y_offset - (channel_width + channel_tolerance)/2, 0])
            cube([board_length, channel_width + channel_tolerance, dish_wall_thickness + channel_depth]);
    }
}

module lid() {
    // Transparent PLA lid — flat disc that sits in the wall recess
    cylinder(d=dish_inner_diameter + 2, h=lid_height);
}

module command_strip_flat() {
    // Flat area on the bottom for command strip adhesion
    translate([-strip_length/2, -strip_width/2, 0])
        cube([strip_length, strip_width, 0.01]);
}

/* === Assembly === */

// Uncomment the part you want to export for printing:

// Main dish body
///*
difference() {
    dish_body();
    // Cut pin channels into the floor
    esp_mount();
}
//*/

// Lid — print separately in transparent PLA
// Translate beside the dish for printing
/*
translate([dish_outer_diameter + 10, 0, 0])
    lid();
*/

// Both together for preview
/*
difference() {
    color("DimGray") dish_body();
    esp_mount();
}
color("LightBlue", 0.5)
    translate([0, 0, dish_height - lid_height])
        lid();
*/
