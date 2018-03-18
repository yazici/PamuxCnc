
EPSILON = 0.001;
WIDE_FACE_UP = 1;
NARROW_FACE_UP = 0;
CW = -90;
CCW = 90;
FLIP = 180;

module CWx()
{
	rotate(a = CW, v=[1,0,0])
		children();
}


module CCWx()
{
	rotate(a = CCW, v=[1,0,0])
		children();
}


module FLIPx()
{
	rotate(a = FLIP, v=[1,0,0])
		children();
}

module CWy()
{
	rotate(a = CW, v=[0,1,0])
		children();
}


module CCWy()
{
	rotate(a = CCW, v=[0,1,0])
		children();
}


module FLIPy()
{
	rotate(a = FLIP, v=[0,1,0])
		children();
}

module CWz()
{
	rotate(a = CW, v=[0,0,1])
		children();
}


module CCWz()
{
	rotate(a = CCW, v=[0,0,1])
		children();
}

module FLIPz()
{
	rotate(a = FLIP, v=[0,0,1])
		children();
}