class FileProcessor

  def initialize(file)
    @file = file.read
  end

  # parse txt file and filter customers according to distance from office
  def filter_nearby_customers(invite_distance = INVITE_DISTANCE_KM)
    customers = []
        
    @file.each_line do |line|
      customer_data = JSON.parse(line)
      if customer_data.present?
        user_id, name, latitude, longitude = customer_data["user_id"].to_i, customer_data["name"], customer_data["latitude"].to_f, customer_data["longitude"].to_f
        customer = Customer.new(
          latitude: latitude,
          longitude: longitude,
          user_id: user_id,
          name: name
        )
        # calcuating distance from office latitude and lingitude
        distance = customer.distance_from()
        if distance <= invite_distance
          customers << customer
        end
      end
    end
    customers
  end
end