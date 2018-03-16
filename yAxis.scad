
module baseFrame()
{
    steelFrame(tableSizeX, tableSizeY);
    
    translate(v = [steelTubeSizeX,tableSizeY/3,0]) {
        steelFrame(tableSizeX-steelTubeSizeY*2, tableSizeY/3);
    }
}


module yAxis()
{
    baseFrame();   
        
    rotate(a = -90, v = [1,0,0])
    {
        linearMotion(travelY, tableSizeX, baseFrameHeight, yAxisMotorShaftHeight, steelTubeSizeX);
    }
}
