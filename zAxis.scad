
zAxisWidth = 200;

zAxisOrigin = [xPos - zAxisWidth/2,
				yPos,
				xAxisBottom];

motorFrameOrigin = gantryFrameOrigin + [xPos, -steelTubeSizeNarrow, gantryFrameHeight];



module motorFrame() 
{
    translate(v = motorFrameOrigin)
    {
        CWx()	
            steelFrame(zAxisWidth, gantryFrameHeight, WIDE_FACE_UP);
        
    }
}


module zLinearMotion(colorScheme)
{
    translate(v = [steelTubeSizeNarrow/2, -zAxisMotorShaftHeight, -travelZ] ) 
    {
        supportedShaft(colorScheme, travelZ, zPos);
    }
    
    translate(v = [zAxisWidth-steelTubeSizeNarrow/2, -zAxisMotorShaftHeight, -travelZ] ) 
    {
        supportedShaft(colorScheme, travelZ, zPos);
    }
    
    translate(v = [zAxisWidth/2,  -2*zAxisMotorShaftHeight, -travelZ+steelTubeSizeWide/2] ) 
    {
        
		ballscrew(colorScheme, travelZ);
		translate(v = [0, 0, zPos]) 
		{
			ballnutSTL();		
			ballnutHousingSTL();
		}
		floatingBallscrewSupport(colorScheme, travelZ);
		fixedBallscrewSupport(colorScheme);
		shaftCouplerSTL();
    }
}



module zAxis()
{
	colorScheme = getColorScheme("zAxis");
    motorFrame();
    translate(v = motorFrameOrigin ) 
    {
		zLinearMotion(colorScheme);
	
		translate(v = [-xPos/2,steelTubeSizeNarrow,0])
		   resize([xPos,0,0], auto=[true,true,true]) 		
			cableChain(colorScheme); 
    }
}

