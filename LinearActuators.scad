module rackAndPinion()
{
}

module chainAndSprocket()
{
}

module beltDrive()
{
}


module ballScrewSupportFixedEnd()
{
}

module ballScrewSupportFloatingEnd()
{
}

module ballScrewNut()
{
}

module ballScrew(length)
{
    color("DarkSlateGray")
    {
        cylinder(r = ballScrewDiameter / 2, h = length);
    }
}
