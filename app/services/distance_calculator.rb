class DistanceCalculator

  def calculate_distance(customer, source_latitude, source_longitude)
    #converting source and destination latitude longitude in radian from degree
    source_latitude, source_longitude = get_radian(source_latitude), get_radian(source_longitude)
    destination_latitude, destination_longitude = get_radian(customer.latitude), get_radian(customer.longitude)

    #applying haversine formula to calculate the distance between 2 points on sphere
    haversine_theta = get_haversine(source_latitude -  destination_latitude) + Math.cos(source_latitude) * Math.cos(destination_latitude) * get_haversine(source_longitude - destination_longitude)

    2 * EARTH_RADIUS_KM * (Math.asin(Math.sqrt(haversine_theta)))
  end

  def get_haversine(value)
    ((1-Math.cos(value))/2.0)
  end
  
  # convert degree to radian
  def get_radian(degrees)
    degrees * Math::PI / 180.0
  end
end