class Currency 
  attr_reader :initial, :from, :to, :result  

  def initialize(initial, from, to, result)
    @initial = initial
    @from = from
    @to = to
    @result = result

  end
end