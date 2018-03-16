module gantryFrame()
{
    translate(v = gantryFrameOrigin)
    {
        rotate(a = 90, v=[1,0,0])
        {
            steelFrame(tableSizeX, gantryFrameHeight);
        }
    }
    
    translate(v = gantryFrameOrigin +[0, gantryFrameGapWidth-steelTubeSizeY, 0])
    {
        rotate(a = 90, v=[1,0,0])
        {
            steelFrame(tableSizeX, gantryFrameHeight);
        }
    }
}

module xAxis()
{
    gantryFrame();
    
    translate(v = gantryFrameOrigin+[0, gantryFrameGapWidth-steelTubeSizeX, gantryFrameHeight] ) 
    {
        rotate(a = -90, v = [1,0,0])
        {
            rotate(a = 90, v = [0,1,0])
            {
                linearMotion(travelX, gantryFrameGapWidth, 0, xAxisMotorShaftHeight, steelTubeSizeX);
            }
        }
    }
}
