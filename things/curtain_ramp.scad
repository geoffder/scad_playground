difference(){
	union(){
		cylinder(h=11.950000, r1=4.000000, r2=4.000000, center=false, $fa=12, $fs=2, $fn=0);
		translate([0.000000, 0.000000, 3.999000])
			linear_extrude(height=20.000000, center=false, convexity=10, slices=20, scale=[0.890196, 0.890196], $fn=16)
				circle(12.750000, $fa=12, $fs=2, $fn=64);
	}
	translate([0.000000, 0.000000, -0.100000])
		cylinder(h=11.150000, r1=24.200000, r2=24.200000, center=false, $fa=12, $fs=2, $fn=64);
	translate([0.000000, 12.750000, 12.000000])
		cube(size=[10.000000, 25.500000, 24.200000], center=true);
}
