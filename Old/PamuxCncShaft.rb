class PamuxCncShaft < PamuxCncModule
  attr_accessor :axis
  
  def initialize (cncMachine, parent)
    super(cncMachine, parent, "#{parent.name} shaft")
    @axis = parent    
  end
end