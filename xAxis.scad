
xAxisBottom = yAxisTop;
xAxisOrigin = [0,yPos,yAxisTop];
gantryFrameHeight = 200;

gantryFrameOrigin = [0, yPos, baseFrameHeight + shaftHeight + openLinearBearingHeight/2];
bottomShaftPos = gantryFrameHeight/2;
ballscrewPos = bottomShaftPos/2;

module gantryFrame()
{
	steelFrame(gantryFrameHeight, tableSizeX, WIDE_FACE_UP);
	verticalBeam(tableSizeX, WIDE_FACE_UP, bottomShaftPos - openLinearBearingWidth/2);
}

module eccentricMountingPlate(colorScheme, pos)
{
	shaftDistance = gantryFrameHeight/2;
	topPlateHeight = openLinearBearingWidth /2 + steelTubeSizeNarrow/2 + shaftBottomToLinearBearingTopDistance;
	bottomPlateHeight = max(travelZ, bottomShaftPos + shaftBottomToMountingPlateTopDistance + openLinearBearingWidth/2);
	
	Color(colorScheme, "mountingPlate")
	{
	
		// TOP
		CCWz() 
			translate([-(openLinearBearingWidth/2 + steelTubeSizeNarrow/2) , -shaftBottomToLinearBearingTopDistance, pos - openLinearBearingOutsideGap/2] )
				rectangularPrism(topPlateHeight, openLinearBearingOutsideGap, mountingPlateThickness);

		// BOTTOM
		translate([-travelZ/2, -shaftBottomToLinearBearingTopDistance, pos - openLinearBearingOutsideGap/2] )
			rectangularPrism(bottomPlateHeight, openLinearBearingOutsideGap, mountingPlateThickness);
		
	}
}


module xLinearMotion(colorScheme)
{
	translate([0, steelTubeSizeNarrow/2, 0])
		CCWz() 
			supportedShaft(colorScheme, travelX, xPos);
	
	translate(v = [bottomShaftPos, 0, 0] ) 
		{
			supportedShaft(colorScheme, travelX, xPos);
		}
		
	translate(v = [ballscrewPos, -ballscrewAssemblyHeight, 0] ) 
	{
		ballscrewAssembly(colorScheme, travelX, xPos);
	}
			
	eccentricMountingPlate(colorScheme,  xPos);
	
	translate(v = [0, steelTubeSizeNarrow, yPos/2 ]) CCWy()
		resize([yPos,0,0], auto=[true,true,true]) 		
			cableChain(colorScheme);
	
}

module xAxis()
{
	colorScheme = getColorScheme("xAxis");
    
    
    translate([0,yPos,gantryFrameHeight+yAxisTop]) 
		CWy()
		{
			gantryFrame();
			translate([0, 0, steelTubeSizeWide])
				xLinearMotion(colorScheme);
		}
}
