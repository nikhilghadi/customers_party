require 'rails_helper'

RSpec.describe DistanceCalculator do
  let(:office_latitude){SOURCE_LATITUDE}
  let(:office_longitude){SOURCE_LONGITUDE}

  

  it "should return zero distance from source to source" do
    customer = Customer.new(user_id:1, name: 'Nikhil', latitude: SOURCE_LATITUDE, longitude: SOURCE_LONGITUDE)
    distance = customer.distance_from()
    expect(distance).to eq(0)
  end

  it "calculate distance from specific point" do
    customer = Customer.new(user_id:1, name: 'Nikhil', latitude: 19.059507, longitude: 72.851108)
    distance = customer.distance_from().to_i
    expect(distance).to eq(10)
  end


  it "calculate distance from specific point" do
    customer = Customer.new(user_id:1, name: 'Nikhil', latitude: 19.143192, longitude: 72.950772)
    distance = customer.distance_from().to_i
    expect(distance).to eq(22)
  end



  it "calculate distance from specific point" do
    customer = Customer.new(user_id:1, name: 'Nikhil', latitude: 59.294289, longitude: -31.870705)
    distance = customer.distance_from().to_i
    expect(distance).to eq(8990)
  end


  it "calculate distance from specific point" do
    customer = Customer.new(user_id:1, name: 'Nikhil', latitude: -20.199292, longitude: -80.087997)
    distance = customer.distance_from().to_i
    expect(distance).to eq(17171)
  end
  
end
