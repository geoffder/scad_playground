difference(){
	union(){
		cylinder(h=4.000000, r1=11.950000, r2=11.950000, center=false);
		translate([0.000000, 0.000000, 3.999000])
			linear_extrude(height=20.000000, center=false, convexity=10, slices=20, scale=0.890196, $fn=16)
				circle(12.750000, $fn=64);
	}
	translate([0.000000, 0.000000, -0.100000])
		cylinder(h=24.200000, r1=11.150000, r2=11.150000, center=false, $fn=64);
	translate([0.000000, 12.750000, 12.000000])
		cube(size=[10.000000, 25.500000, 24.200000], center=true);
}
