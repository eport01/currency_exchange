class Currency 
  attr_reader :result 
  def initialize(attributes)
    @result = attributes[:result]
  end
end