include <MCAD\motors.scad>
include <MCAD\materials.scad>

E=0.001;
ballScrewDiameter = 20;



module shaftCouplerSTL()
{
	import("STL/shaftCoupler.stl");
}

module ballscrewSTL(color, length)
{
color(color)
	CWy()
		translate(v = [0, -35, -22] ) 
			resize([length,0,0], auto=[true,false,false]) 
				import("STL/ballscrew.stl");
}

module ballnutSTL()
{
	import("STL/ballnut.stl");
}


module ballnutHousingSTL()
{
	import("STL/ballnutHousing.stl");
}


module floatingBallscrewSupportSTL(length)
{
	
	translate(v = [0, 0, length] ) 
	import("STL/floatingBallscrewSupport.stl");
}


module fixedBallscrewSupportSTL()
{
	import("STL/fixedBallscrewSupport.stl");
}

module rackAndPinion()
{
}

module chainAndSprocket()
{
}

module beltDrive()
{
}



module sprial(d1,d2,H)
{
 difference()
 {
  cylinder(d=d2,h=H);
  translate([0,0,-E])   
	cylinder(d=d1,h=H+2*E);
 } 
}

	
module ballnut()
{
	
	

	difference()
	{
		 sprial(8,10.20,1.5);
		 translate([0,0,1.5])   
			sprial(8,22,3.5);
		 translate([0,0,5])     
			sprial(8,10.20,10);
		 
		 translate([8,0,0])     cylinder(d=3.6,h=5+E);
		 translate([-8,0,0])    cylinder(d=3.6,h=5+E);
		 translate([0,8,0])     cylinder(d=3.6,h=5+E);
		 translate([0,-8,0])    cylinder(d=3.6,h=5+E);
	}
}

module threads()
{
	Res=10;

	for(i=[0:Res:149*360-10])
	{
		hull()
		{
			translate([0,0,i/180])  rotate([0,0,i]) translate([6/2,0,0]) rotate([90,0,0])cylinder(d=2.3094,h=E,$fn=3);
			translate([0,0,(i+Res)/180])  rotate([0,0,i+Res]) translate([6/2,0,0]) rotate([90,0,0])cylinder(d=2.3094,h=E,$fn=3);
		}
	}
}

module ballscrew(length)
{
    color(Stainless)
    {
		cylinder(d=ballScrewDiameter,h=length);
		*translate([0,0,1])     
			threads();
 
    }
}

