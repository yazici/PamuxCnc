
shaftDiameter = 20;
shaftRadius = shaftDiameter / 2;

shaftSupportHeight = 30;
shaftSupportWidth = 30;

shaftHeight = shaftDiameter + shaftSupportHeight;

openLinearBearingWidth  = 40;
openLinearBearingLength = 50;
openLinearBearingHeight = 20;
openLinearBearingGap = 100;

ballScrewDiameter = 20;

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


module mountingPlate(colorScheme, pos)
{
	Color(colorScheme, "mountingPlate")
		translate(v = [-linearBearingWidth/2, -shaftBottomToLinearBearingVerticalDistance, pos -openLinearBearingGap/2] ) 
			CCWx()
				rectangularPrism(linearBearingWidth, linearBearingWidth + openLinearBearingGap, linearBearingPlateThickness);
}

module supportedShaft(colorScheme, length, pos)
{
	union () {
		Color (colorScheme, "shaft") 
			sbr20(length);
		
		translate(v = [0, -shaftSupportHeight, pos - openLinearBearingGap/2] ) 
		Color (colorScheme, "linearBearing") 
			openLinearBearing();
			
		translate(v = [0, -shaftSupportHeight, pos + openLinearBearingGap/2] ) 
		Color (colorScheme, "linearBearing")
			openLinearBearing();
		
		mountingPlate(colorScheme, pos);	
	}
	
}




