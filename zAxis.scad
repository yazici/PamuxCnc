module motorFrame() {
    
}

module zAxis()
{
    motorFrame();
    translate(v = motorFrameOrigin ) 
    {
      linearMotion(travelZ, motorFrameWidth, 0, zAxisMotorShaftHeight, steelTubeSizeX);
    }
}

