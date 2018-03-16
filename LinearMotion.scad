
module openLinearBearing()
{
    color(Aluminum)
    {
        cube([openLinearBearingWidth, openLinearBearingHeight, openLinearBearingLength]);
    }
}


module shaft(length)
{
    color(Stainless)
    {
        cylinder(r = shaftDiameter / 2, h = length);
    }
}


module shaftSupport(length)
{
    color(Aluminum)
    {
        cube([shaftSupportWidth, shaftSupportHeight, length]);
    }
}


module supportedShaft(length)
{
    union()
    {
        translate(v = [0, -shaftSupportHeight-shaftDiameter/2, 0] ) 
        {
            shaft(length);
            translate(v = [-openLinearBearingWidth/2, -openLinearBearingHeight, length/3] ) 
            {
                openLinearBearing();
            }
            
            translate(v = [-openLinearBearingWidth/2, -openLinearBearingHeight, length/3 + openLinearBearingGap] ) 
            {
                openLinearBearing();
            }
        }
        translate(v = [-shaftSupportWidth/2, -shaftSupportHeight, 0] ) 
        {
            shaftSupport(length);
        }
    }
}


module linearMotion(travel, shaftDistance, elevation, motorShaftHeight, startPosition)
{
    translate(v = [steelTubeSizeY/2, -elevation, startPosition] ) 
    {
        supportedShaft(travel);
    }
    
    translate(v = [shaftDistance-steelTubeSizeY/2, -(elevation), startPosition] ) 
    {
        supportedShaft(travel);
    }
    
    translate(v = [shaftDistance/2, -(elevation + motorShaftHeight), startPosition] ) 
    {
        ballScrew(travel);
    }
}