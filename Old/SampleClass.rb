#RUBY: $ global, @ instance variables, @@  class/static variables

class SampleClass
  attr_accessor :xSize
  attr_accessor :ySize
  attr_accessor :zSize
  
  @@classVariable = 1
  @instanceVariable = 1
  
  attr_reader :name
  attr_writer :name
  
  def name2
    @name
  end

  def name2=(str)
    @name = str
  end
  
  def initialize xSize, ySize, zSize
    self.xSize = xSize
    self.ySize = ySize
    self.zSize = zSize
  end
  
  #Foo.classMethod('Tim')

  #foo1 = Foo.new
  #foo1.instanceMethod('Bob')

  def SampleClass.classMethod(param)
   puts "In a class/static method"
  end
  
  def instanceMethod(param)
   puts "In an instance method"
  end
   
   
  def to_s
    "#{xSize} #{ySize} #{zSize}"
  end
end