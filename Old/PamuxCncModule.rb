class PamuxCncModule < PamuxCncObject
  def initialize(cncMachine, parent, name, metaData = "")
    super(cncMachine, parent, name, metaData)
  end
  
  def startBuildImpl()
    PamuxReporting.startModuleBuild @name
  end
  
  def buildImpl()
  end
  
  def buildVerifyImpl()
  end
  
  def finishBuildImpl()
    PamuxReporting.finishModuleBuild
  end
  
  def build()
    startBuildImpl
    buildImpl
    finishBuildImpl
    buildVerifyImpl
    
  end  
end