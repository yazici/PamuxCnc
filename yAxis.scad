yAxisOrigin = [0,0,0];

baseFrameHeight = steelTubeSizeWide;

yAxisTop = baseFrameHeight + shaftBottomToLinearBearingVerticalDistance + linearBearingPlateThickness;

module baseFrame()
{
    steelFrame(tableSizeX, tableSizeY, NARROW_FACE_UP);
    
	horizontalBeam(tableSizeX, NARROW_FACE_UP, tableSizeY*2/3);
    horizontalBeam(tableSizeX, NARROW_FACE_UP, tableSizeY/3);
}


module yLinearMotion(colorScheme)
{
	
    translate(v = [steelTubeSizeWide/2, -baseFrameHeight, steelTubeSizeNarrow] ) 
    {
        supportedShaft(colorScheme, travelY, yPos);
    }

	translate(v = [steelTubeSizeWide/2, -(baseFrameHeight - yAxisMotorShaftHeight), steelTubeSizeNarrow] ) 
    {
        
		ballscrew(colorScheme, travelY);
		translate(v = [0, 0, yPos]) 
		{
			ballnutSTL();
			ballnutHousingSTL();
		}
		floatingBallscrewSupport(colorScheme, travelY);
		fixedBallscrewSupport(colorScheme);
		shaftCouplerSTL();
    }
    
    translate(v = [tableSizeX-steelTubeSizeWide/2, -(baseFrameHeight), steelTubeSizeNarrow] ) 
    {
        supportedShaft(colorScheme, travelY, yPos);
    }
    
    translate(v = [tableSizeX-steelTubeSizeWide/2, -(baseFrameHeight - yAxisMotorShaftHeight), steelTubeSizeNarrow] ) 
    {
        
		ballscrew(colorScheme, travelY);
		translate(v = [0, 0, yPos]) 
		{
			ballnutSTL();
			ballnutHousingSTL();
		}
		floatingBallscrewSupportSTL(travelY);
		fixedBallscrewSupportSTL();
		shaftCouplerSTL();
    }
}



module yAxis()
{
    baseFrame();   
        
    CWx()
    {
		yLinearMotion(getColorScheme("yAxis"));
	}
}
