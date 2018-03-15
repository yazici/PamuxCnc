class PamuxCncBaseTable < PamuxCncModule
  def initialize (cncMachine, parent)
    super(cncMachine, parent, "base table")
  end
  
  def buildImpl()
    squareSteelTubeDefinition = Sketchup.active_model.definitions["SquareSteelTube"]
    
    puts(squareSteelTubeDefinition.name)
    
    @componentInstance = Sketchup::active_model.active_entities.add_instance(squareSteelTubeDefinition, IDENTITY)
  end
end