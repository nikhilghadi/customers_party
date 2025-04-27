require 'rails_helper'

RSpec.describe CustomerFilter do

  it "should return zero customers" do
    all_customers = [
      Customer.new(user_id:1, name: 'Rohit Mehra', latitude: 59.294289, longitude: -31.870705),
      Customer.new(user_id:2, name: 'Krishna Mehra', latitude: -20.199292, longitude: -80.087997)
    ]
    customers = CustomerFilter.new(all_customers, 100).filter
    expect(customers.count).to eq(0)
  end


  it "should return 2 customers " do
    all_customers = [
      Customer.new(user_id:1, name: 'Rohit Mehra', latitude: 59.294289, longitude: -31.870705),
      Customer.new(user_id:2, name: 'Krishna Mehra', latitude: -20.199292, longitude: -80.087997),
      Customer.new(user_id:3, name: 'Bhavesh Joshi', latitude: 19.059507, longitude: 72.851108),
      Customer.new(user_id:4, name: 'Salaman Khan',  latitude: 19.143192, longitude: 72.950772)
    ]
    customers = CustomerFilter.new(all_customers, 100).filter
    expect(customers.count).to eq(2)
    expect( customers.map(&:user_id)).to eq( [3,4])
  end


  it "should return 1 customers with 20 KM distance " do
    all_customers = [
      Customer.new(user_id:1, name: 'Rohit Mehra', latitude: 59.294289, longitude: -31.870705),
      Customer.new(user_id:2, name: 'Krishna Mehra', latitude: -20.199292, longitude: -80.087997),
      Customer.new(user_id:3, name: 'Bhavesh Joshi', latitude: 19.059507, longitude: 72.851108),
      Customer.new(user_id:4, name: 'Salaman Khan',  latitude: 19.143192, longitude: 72.950772)
    ]
    customers = CustomerFilter.new(all_customers, 20).filter
    expect(customers.count).to eq(1)
    expect( customers.map(&:user_id)).to eq( [3])
  end

end