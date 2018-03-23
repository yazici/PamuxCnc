
zAxisWidth = 200;

zAxisOrigin = [xPos - zAxisWidth/2,
				yPos,
				xAxisBottom];

module motorFrame() 
{
	steelFrame(zAxisWidth, gantryFrameHeight, WIDE_FACE_UP);
}


module zLinearMotion(colorScheme)
{
    translate(v = [openLinearBearingWidth/2, 0, 0] ) 
    {
        supportedShaft(colorScheme, travelZ, zPos);		
    }
    
    translate(v = [zAxisWidth-openLinearBearingWidth/2, 0, 0] ) 
    {
		supportedShaft(colorScheme, travelZ, zPos);
		
    }
	
	
    translate(v = [zAxisWidth/2,  -ballscrewCenterHeight, travelZ - 20] ) 
    {        
		FLIPy() 
			ballscrewAssembly(colorScheme, travelZ, zPos);
    }
	
	translate(v = [0,0, 0] )
	
	
	//colorScheme, elevation, width, length, offset, pos
	
	endToEndMountingPlate(colorScheme, 
							shaftBottomToLinearBearingTopDistance, 
							zAxisWidth,
							openLinearBearingOutsideGap, 
							
							0,							
							zPos);
					
		
	translate([-xPos,steelTubeSizeNarrow,-2*zPos])
		CWz()			
		   resize([xPos,0,0], auto=[true,true,true]) 		
				cableChain(colorScheme); 
}



module zAxis()
{
	colorScheme = getColorScheme("zAxis");
    
	translate([xPos - zAxisWidth/2, yPos - shaftBottomToMountingPlateTopDistance,gantryFrameHeight])
    {
		zLinearMotion(colorScheme);
    }
}

