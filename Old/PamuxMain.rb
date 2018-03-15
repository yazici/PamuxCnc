require 'sketchup.rb'

# r equire 'C:\\mysrc\\Sketchup\\PamuxSketchupUtils.rb'
# r equire 'C:\\mysrc\\Sketchup\\PamuxCncMachine.rb'


load 'C:\\mysrc\\Sketchup\\PamuxSketchupUtils.rb'

load 'C:\\mysrc\\Sketchup\\PamuxReporting.rb'

load 'C:\\mysrc\\Sketchup\\PamuxCncObject.rb'

load 'C:\\mysrc\\Sketchup\\PamuxCncModule.rb'


load 'C:\\mysrc\\Sketchup\\PamuxCncMachine.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncBaseTable.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncLimitSwitch.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncShaft.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncBallScrew.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncAxis.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncFixedGantry.rb'

load 'C:\\mysrc\\Sketchup\\PamuxCncSpindle.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncCoolant.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncDustShoe.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncPowerSupply.rb'
load 'C:\\mysrc\\Sketchup\\PamuxCncController.rb'


# load 'C:\\mysrc\\Sketchup\\PamuxMain.rb'

#SKETCHUP_CONSOLE.show

$scriptName = 'PamuxMain.rb'
$scriptPath = 'C:\\mysrc\\Sketchup\\#{$scriptName}'
$pluginsFolder = 'C:\\Users\\bayazic\\AppData\\Roaming\\SketchUp\\SketchUp 2017\\SketchUp\\Plugins'
$pluginPath = '#{$pluginsFolder}\\#{$scriptName}'

#UI.menu("Plugins").add_item("Build CNC Machine") {
#  $machine = PamuxCncMachine.new 1300, 1300, 300
#  $machine.build()
#}

$machine = PamuxCncMachine.new 1300, 1300, 300
$machine.build()