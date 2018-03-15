class PamuxReporting
  @@indentation = 1
  
  def PamuxReporting.reportBuildStep(type, name)  
  
    indentationStr = ""
    (1..@@indentation).each {|i| indentationStr += " "}
    
    puts "#{indentationStr}#{type}:#{name}"
  end 
  
  def PamuxReporting.start(type, name)  
    PamuxReporting.indent
    PamuxReporting.reportBuildStep type, name
  end
  
  def PamuxReporting.finish()  
    PamuxReporting.unindent    
  end
  
  ##################################################################
  
  def PamuxReporting.startModuleBuild(moduleName)  
    PamuxReporting.start "BUILDING MODULE", moduleName
  end
  
  def PamuxReporting.finishModuleBuild
    PamuxReporting.finish
  end
  
  ##################################################################
  
  def PamuxReporting.startConnectingModules(parentModule, childModule)  
    PamuxReporting.start "CONNECTING MODULE", "#{childModule.name} TO #{parentModule.name}"
  end
  
  def PamuxReporting.finishConnectingModules
    finish
  end
  
  ##################################################################
  
  def PamuxReporting.reportVerificationStep(type, name)  
    PamuxReporting.reportBuildStep "VERIFICATION #{type}", name
  end
  
  def PamuxReporting.reportCalibrationStep(type, name)  
    PamuxReporting.reportBuildStep "CALIBRATION #{type}", name
  end
  
  def PamuxReporting.reportAlignmentStep(name)
    PamuxReporting.indent
    PamuxReporting.reportVerificationStep "PRECISE ALIGNMENT", name
    PamuxReporting.unindent
  end
  
  ##################################################################
  
  def PamuxReporting.startVerification(name)  
    PamuxReporting.indent
    PamuxReporting.reportVerificationStep "TEST", name
  end
  
  def PamuxReporting.finishVerification
    PamuxReporting.finish
  end
  
  ##################################################################
  
  def PamuxReporting.startCalibration(name)  
    PamuxReporting.indent
    PamuxReporting.reportCalibrationStep name
  end
  
  def PamuxReporting.finishCalibration
    PamuxReporting.finish
  end
  
  def PamuxReporting.indent
    @@indentation += 2
  end 
  
  def PamuxReporting.unindent
    @@indentation -= 2
  end 
  
end