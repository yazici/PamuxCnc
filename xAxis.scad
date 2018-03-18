
xAxisBottom = yAxisTop;
xAxisOrigin = [0,yPos,yAxisTop];
gantryFrameHeight = travelZ;

gantryFrameOrigin = [0, yPos, baseFrameHeight + shaftHeight + openLinearBearingHeight/2];


module gantryFrame()
{
    translate(v = gantryFrameOrigin + [0, 0, steelTubeSizeNarrow])
    {
        CCWx()
        {
            steelFrame(tableSizeX,  gantryFrameHeight, WIDE_FACE_UP);
        }
    }
    
    translate(v = gantryFrameOrigin + [0, -steelTubeSizeNarrow, 0])
    {
		steelFrame(tableSizeX, gantryFrameHeight, WIDE_FACE_UP);
    }
}


module xLinearMotion(color)
{

	shaftDistance = gantryFrameHeight/2;
    
	translate(v = [0, 0, steelTubeSizeNarrow] ) 
    {
        supportedShaft(color, travelX, xPos);
    }
	
	CCWz()
		translate(v = [shaftDistance, -steelTubeSizeNarrow/2, steelTubeSizeNarrow] ) 
		{
			supportedShaft(color, travelX, xPos);
		}
   
   
    CCWz()
		translate(v = [shaftDistance/2, -steelTubeSizeNarrow*3/2, steelTubeSizeNarrow] ) 
    {
        
		ballscrewSTL(color, travelX);
		
		
		translate(v = [0, 0, xPos]) 
		{
			ballnutSTL();
			ballnutHousingSTL();
		}
		
		floatingBallscrewSupportSTL(travelX);
		fixedBallscrewSupportSTL();
		shaftCouplerSTL();
		
    }
}

module xAxis(color)
{
    gantryFrame();
    
    translate(v = gantryFrameOrigin+[0, -steelTubeSizeNarrow/2, gantryFrameHeight + steelTubeSizeWide/2] ) 
    {
		
		CWx()
			CCWy()
				xLinearMotion(color);
            
    }
	
	
}
