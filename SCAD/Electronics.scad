module StepperDriver()
{
}

module PowerSupply()
{
}

module StepperController()
{
}

module Microcontroller()
{
}

module PanelPC()
{
}

module LimitSwitch()
{
}


module cableChainSTL()
{
	import("STL/cableChain.stl");
}



module cableChain(colorScheme)
{
	Color(colorScheme, "cableChain")
		import("STL/cableChain.stl");
}


module EStop()
{
}

module ZHomingTool()
{
}

