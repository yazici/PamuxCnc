


colorSchemes = [
	[ "xAxis",  [ ["shaft" , Stainless], 	["ballscrew" , "Red"], 		["linearBearing" , Aluminum], 		["endSupport" , "DarkSlateGray"], 		["mountingPlate" , "DimGray"], 		["cableChain" , "Black"] ]], 
	[ "yAxis",  [ ["shaft" , Stainless], 	["ballscrew" , "Green"], 	["linearBearing" , Aluminum], 		["endSupport" , "DarkSlateGray"], 		["mountingPlate" , "DimGray"], 		["cableChain" , "Black"] ]], 
	[ "zAxis",  [ ["shaft" , Stainless], 	["ballscrew" , "Navy"], 	["linearBearing" , Aluminum], 		["endSupport" , "DarkSlateGray"], 		["mountingPlate" , "DimGray"], 		["cableChain" , "Black"] ]]
];
		 
function getColorScheme(colorSchemeName)  = colorSchemes[search([str(colorSchemeName)], colorSchemes)[0]][1];
function getColor(colorScheme, colorName)  = colorScheme[search([str(colorName)], colorScheme)[0]][1];
		
		
module getColorSchemeTest(colorSchemeName)
{
	echo ("getColorSchemeTest input: " , colorSchemeName);
	echo ("getColorSchemeTest:" , getColorScheme(colorSchemeName));
	
}

	
module getColorTest(colorScheme, colorName)
{

	echo ("getColorTest input: " , colorScheme, colorName);
	
	echo ("getColorTest:" , getColor(colorScheme, colorName));
	
}


module Color(colorScheme, colorName)
{
	
	color(getColor(colorScheme, colorName))
		children();
}
