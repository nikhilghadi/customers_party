class CustomerFilter
  def initialize(customers, invite_distance = INVITE_DISTANCE_KM)
    @customers = customers
    @invite_distance = invite_distance
  end

  def filter
    @customers.select{|customer| customer.distance_from <= @invite_distance}
  end
end