class FileProcessor

  def initialize(file)
    @file = file.read
  end

  # parse txt file and create Customer objects
  def parse_customers(invite_distance = INVITE_DISTANCE_KM)
    customers = []
    # TODO
    # In future we can parse the large file in background using sidekiq
    @file.each_line do |line|
      customer_data = JSON.parse(line) rescue nil
      if is_valid_data?(customer_data)
        user_id, name, latitude, longitude = customer_data["user_id"].to_i, customer_data["name"], customer_data["latitude"].to_f, customer_data["longitude"].to_f
        customer = Customer.new(
          latitude: latitude,
          longitude: longitude,
          user_id: user_id,
          name: name
        )
        customers << customer
      end
    end
    customers
  end

  def is_valid_data?(data)
    data.present? && data["user_id"].present? && data["name"].present? && data["latitude"].present? && data["longitude"].present?
  end
end