

// http://www.onlinemetals.com/merchant.cfm?pid=22487&step=4&showunits=inches&id=1646&top_cat=197
// 1018 MILD STEEL SQUARE TUBE (METRIC SIZE) 40MM X 3MM WALL 60" LONG

//steelTubeSizeNarrow = 40;
//steelTubeSizeWide = 40;
//steelTubeWallThickness = 3;
//steelTubeCornerRadius = 0.25 * 25.4;

// http://www.onlinemetals.com/merchant.cfm?pid=10326&step=4&showunits=inches&id=845&top_cat=849




//steelTubeSizeNarrow = 1; 
//steelTubeSizeWide = 2; 
//steelTubeWallThickness = 0.2;
//steelTubeCornerRadius = 0.1;


function steelTubeFaceWidth(whichFaceUp) = whichFaceUp == WIDE_FACE_UP ? steelTubeSizeWide : steelTubeSizeNarrow;
function steelTubeDepth(whichFaceUp) = whichFaceUp == NARROW_FACE_UP ? steelTubeSizeWide : steelTubeSizeNarrow;


module miterCutTriangle(tubeFaceWidth, tubeDepth, height)
{
    hull()
    {
	
		cylinder(r = EPSILON, h = height);
        
        
		translate([tubeFaceWidth, 0, 0])
		{
            cylinder(r = EPSILON, h = height);
        }
        
		translate([0, tubeDepth, 0])
		{
            cylinder(r = EPSILON, h = height);
        }
    }
}


module rectangularPrism(width, length, height)
{
    hull()
    {
	
		cylinder(r = EPSILON, h = height);
        
        
		translate([0, length, 0])
		{
            cylinder(r = EPSILON, h = height);
        }
        
		translate([width, length, 0])
		{
            cylinder(r = EPSILON, h = height);
        }
		
		translate([width, 0, 0])
		{
            cylinder(r = EPSILON, h = height);
        }
    }
}


module rightTriangle(tubeFaceWidth, tubeDepth, height)
{
    polyhedron(
               points=[[0,0,0], [tubeFaceWidth, 0, 0], [0, tubeDepth, 0], 
                       [0,0,height], [tubeFaceWidth, 0, height], [0, tubeDepth, height]],
    // Clockwise, lookiong from outside inwards
               faces=[[2,1,0],[5,3,4],[2, 5, 4, 1], [5,2,0,3], [1,4,3,0]]
               );
    
}

module roundedSquareRod(tubeFaceWidth, tubeDepth, length, cornerRadius)
{
    color(Steel) { 
      hull()
      {
          translate([cornerRadius, cornerRadius, 0]) {
              cylinder(r = cornerRadius, h = length);
          }
          
          
           translate([cornerRadius, tubeDepth - cornerRadius, 0]) {
              cylinder(r = cornerRadius, h = length);
          }
          
           translate([tubeFaceWidth-cornerRadius, tubeDepth-cornerRadius, 0]) {
              cylinder(r = cornerRadius, h = length);
          }
          
           translate([tubeFaceWidth-cornerRadius, cornerRadius, 0]) {
              cylinder(r = cornerRadius, h = length);
          }
      }
    }
}

module roundedSquareTube(tubeFaceWidth, tubeDepth, length, cornerRadius, wallThickness)
{
    difference() {
        roundedSquareRod(tubeFaceWidth, tubeDepth, length, cornerRadius);
        translate([wallThickness,wallThickness,-EPSILON/2]) {
            roundedSquareRod(tubeFaceWidth-wallThickness*2, tubeDepth-wallThickness*2, length+EPSILON, cornerRadius/2);
        }
    }
}

module bottomMiterCut(tubeFaceWidth, tubeDepth)
{

  translate(v=[0,tubeDepth,0]) 
  {
    CCWx()
    {

      miterCutTriangle(tubeFaceWidth, tubeFaceWidth, height = tubeDepth);
    }
  }
}

module topMiterCut(tubeFaceWidth, tubeDepth, length)
{
  translate(v=[0,0,length]) 
  {
    CWx()
    {
      miterCutTriangle(tubeFaceWidth, tubeFaceWidth, height = tubeDepth);
    }
  }
}

module miteredRoundedSquareTube(tubeFaceWidth, tubeDepth, length, cornerRadius, wallThickness)
{
    
    difference()
    {
        difference()
        {
            roundedSquareTube(tubeFaceWidth, tubeDepth, length, cornerRadius, wallThickness);
            bottomMiterCut(tubeFaceWidth, tubeDepth);
        }
        topMiterCut(tubeFaceWidth, tubeDepth, length);
    }    
}

module frameBottomTube(frameSizeX, frameSizeY, tubeFaceWidth, tubeDepth)
{ 
    translate(v=[0, tubeFaceWidth, tubeDepth])
	{
        CWx() 
			CCWy()		
				miteredRoundedSquareTube(tubeFaceWidth, tubeDepth, frameSizeX, steelTubeCornerRadius, steelTubeWallThickness); 
        
    }
}

module frameTopTube(frameSizeX, frameSizeY, tubeFaceWidth, tubeDepth)
{ 
    translate(v=[0, frameSizeY-tubeFaceWidth, 0])
	{
		CCWx() 
			CCWy()
				miteredRoundedSquareTube(tubeFaceWidth, tubeDepth, frameSizeX, steelTubeCornerRadius, steelTubeWallThickness); 
    }
}


module frameLeftTube(frameSizeX, frameSizeY, tubeFaceWidth, tubeDepth) 
{
    translate(v=[tubeFaceWidth, 0, 0])
    {
        FLIPy()
			CWx()
				miteredRoundedSquareTube(tubeFaceWidth, tubeDepth, frameSizeY, steelTubeCornerRadius, steelTubeWallThickness); 
            
    }
}
module frameRightTube(frameSizeX, frameSizeY, tubeFaceWidth, tubeDepth) 
{ 
    translate(v=[frameSizeX-tubeFaceWidth, 0, tubeDepth])
    {
        CWx()
            miteredRoundedSquareTube(tubeFaceWidth, tubeDepth, frameSizeY, steelTubeCornerRadius, steelTubeWallThickness); 
       
    }
}


// Only these functions use whichFaceUp

module steelFrame(frameSizeX, frameSizeY, whichFaceUp) {

	tubeFaceWidth = steelTubeFaceWidth(whichFaceUp);
	tubeDepth = steelTubeDepth(whichFaceUp);
    union() {
        frameLeftTube(frameSizeX, frameSizeY, tubeFaceWidth, tubeDepth);
        
        frameRightTube(frameSizeX, frameSizeY, tubeFaceWidth, tubeDepth);
    }

    union() {
        frameBottomTube(frameSizeX, frameSizeY, tubeFaceWidth, tubeDepth);
        
        frameTopTube(frameSizeX, frameSizeY, tubeFaceWidth, tubeDepth);
    }
}

module horizontalBeam(frameSizeX, whichFaceUp, yPosition)
{
	tubeFaceWidth = steelTubeFaceWidth(whichFaceUp);
	tubeDepth = steelTubeDepth(whichFaceUp);
	
	translate(v = [tubeFaceWidth,
					yPosition,
					0]) 
	{
		CCWy()
			CCWz()
				roundedSquareTube(tubeFaceWidth, tubeDepth, frameSizeX - tubeFaceWidth*2, steelTubeCornerRadius, steelTubeWallThickness);
    }
}

