
EPSILON = 0.001;

WIDE_FACE_UP = 1;
NARROW_FACE_UP = 0;



LEFT = 0;
TOP = 1;
RIGHT = 2;
BOTTOM = 3;

MASTER = 1;
SLAVE = 2;

module CWx()
{
	rotate([90,0,0])
		children();
}


module CCWx()
{
	rotate([-90,0,0])
		children();
}


module FLIPx()
{
	rotate([180,0,0])
		children();
}

module CWy()
{
	rotate([0,90,0])
		children();
}


module CCWy()
{
	rotate([0,-90,0])
		children();
}


module FLIPy()
{
	rotate([0,180,0])
		children();
}

module CWz()
{
	rotate([0,0,90])
		children();
}


module CCWz()
{
	rotate([0,0,-90])
		children();
}

module FLIPz()
{
	rotate([0,0,180])
		children();
}