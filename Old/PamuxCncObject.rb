class PamuxCncObject
  attr_accessor :cncMachine
  attr_accessor :name
  attr_accessor :parent
  attr_accessor :metaData
  
  def initialize(cncMachine, parent, name, metaData)
    @cncMachine = cncMachine
    @name = name    
    @parent = parent
    @metaData = metaData
  end
  
end  