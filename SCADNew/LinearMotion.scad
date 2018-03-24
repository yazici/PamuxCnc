
shaftDiameter = 20;
shaftRadius = shaftDiameter / 2;

shaftSupportHeight = 30;
shaftSupportWidth = 30;

shaftHeight = shaftDiameter + shaftSupportHeight;

openLinearBearingWidth  = 48;
openLinearBearingLength = 50;
openLinearBearingHeight = 20;
openLinearBearingGap = 100;

openLinearBearingOutsideGap = openLinearBearingLength*2 + openLinearBearingGap;


ballScrewDiameter = 20;

nutHousingWidth =  62;
nutHousingHeight =  44;
nutHousingCenterToTop =  22;



ballscrewCenterHeight = 25;
ballscrewFixedSideShaftLength = 40;
ballscrewFloatingSideShaftLength = 5;

ballscrewAssemblyHeight = ballscrewCenterHeight;

function ballscrewThreadedLength(length) = length-ballscrewFixedSideShaftLength-ballscrewFloatingSideShaftLength;


/*

//
//https://www.wikihow.com/Read-a-Screw-Thread-Callout
//
// #4-40 x .5  (Unified threads, inches, 0: smallest, 10:largest)  Major diameter =  0.060" + (numbered diameter -#4-) * 0.013"... For Unified threads, the number 40 given is threads per inch. 
// 1/4-20 x 5/8
// M3-0.50 x 10 ( the number following the M is the major diameter of the external thread in millimeters. the thread pitch -0.50- is  in millimeters per thread. fine/coarse)
// The first number gives the major, or largest, diameter. 
// The second number. It relates to the distance between adjacent threads. It may be given as the number of threads per unit length, 
// or it may be given as the distance between threads (also called the thread pitch).
// length, is generally given after the x. The length of most screws is measured from the bottom of the head
// Thread classes refer to fitting how loosely or tightly the screw fits in the nut. The most common thread classes are 2A or 2B. 
// "A" indicates an external thread, such as on a screw or bolt. B indicates an internal thread
//  UNC and UNF. These stand for unified coarse and unified fine
//
// https://en.wikipedia.org/wiki/Engineering_drawing_abbreviations_and_symbols
// https://en.wikipedia.org/wiki/Diameter#Diameter_symbol    U+2300 Diameter sign  is U+00F8 ø (HTML &#248; · &oslash;)

*/

shaftSupportHoleSize = "ø5.5"; 		

ballnutHousingNutSize = "M6"; 	// SBR20UU. M6, Threaded holes

module sbr20(length)
{
	//m8 bolts
	// 45 mm wide on the bottom 
	// 27 mm bottom to center	
	// 37 mm full height (27+10)
	
	FLIPz()
		translate(v = [0, 27, length] ) 
			resize([45,37,length]) 
				import("STL/sbr20.stl");
}

module openLinearBearingSTL()
{
	//m8 bolts
	// 48 mm wide 39mm high 50 mm
	
	import("STL/sbr20uu.stl");
}

module openLinearBearing()
{
    color(Aluminum)
    {
		openLinearBearingSTL();
	}
}


module shaft(length)
{
    color(Stainless)
    {
		//sbr20(length);
       cylinder(r = shaftDiameter / 2, h = length);
    }
}


module shaftSupport(length)
{
    color(Aluminum)
    {
        cube([shaftSupportWidth, shaftSupportHeight, length]);
    }
}

module mountingPlateRaw(pos)
{
	translate(v = [0, pos -openLinearBearingOutsideGap/2, 0] ) 
		rectangularPrism(openLinearBearingWidth, openLinearBearingOutsideGap, mountingPlateThickness);
}

module mountingPlate(colorScheme, pos)
{
	Color(colorScheme, "mountingPlate")
		translate(v = [-openLinearBearingWidth/2, -shaftBottomToLinearBearingTopDistance, 0] ) 
			CCWx()
				mountingPlateRaw(pos);
}

module endToEndMountingPlate(colorScheme, elevation, width, length, offset, pos)
{

	Color(colorScheme, "mountingPlate")
		translate(v = [-offset, -elevation, pos - width/2] )
				rectangularPrism(length + offset*2, width, mountingPlateThickness);
}



module supportedShaft(colorScheme, length, pos)
{
	union () {
		Color (colorScheme, "shaft") 
			sbr20(length);
		
		translate(v = [0, -shaftSupportHeight, pos - (openLinearBearingGap/2 + openLinearBearingLength)] ) 
		Color (colorScheme, "linearBearing") 
			openLinearBearing();
			
		translate(v = [0, -shaftSupportHeight, pos + openLinearBearingGap/2] ) 
		Color (colorScheme, "linearBearing")
			openLinearBearing();
		
		//mountingPlate(colorScheme, pos);	
	}
	
}




include <MCAD\motors.scad>
include <MCAD\materials.scad>

E=0.001;

ballScrewDiameter = 20;
ballscrewFixedSideShaftLength = 40;
ballscrewFloatingSideShaftLength = 5;

function ballscrewThreadedLength(length) = length-ballscrewFixedSideShaftLength-ballscrewFloatingSideShaftLength;

module shaftCouplerSTL()
{	
	import("STL/shaftCoupler.stl");
}

module shaftCoupler(colorScheme)
{
	Color(colorScheme, "shaftCoupler")
		shaftCouplerSTL();
}


module ballscrewSTL()
{
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

module ballscrew(colorScheme, length)
{
    Color(colorScheme, "ballscrew")
		resize([0,0,length], auto=[false, false, true]) 
			ballscrewSTL();
}


module floatingBallscrewSupport(colorScheme, length)
{
	Color(colorScheme, "endSupport")
		floatingBallscrewSupportSTL(length);
}


module fixedBallscrewSupport(colorScheme)
{
	Color(colorScheme, "endSupport")
		fixedBallscrewSupportSTL();
}

module ballscrewAssembly(colorScheme, length, nutPosition)
{	
	fixedBallscrewSupport(colorScheme);
	
	translate(v = [0, 0, -ballscrewFixedSideShaftLength])
	{
		ballscrew(colorScheme, length);
		shaftCoupler(colorScheme);
		translate(v = [0, 0, -ballscrewFixedSideShaftLength/2])
			stepper_motor_mount(23);
	}

	floatingBallscrewSupport(colorScheme, length-ballscrewFixedSideShaftLength-ballscrewFloatingSideShaftLength);
	
	translate(v = [0, 0, nutPosition]) 
	{
		ballnutSTL();
		ballnutHousingSTL();
	}
}
