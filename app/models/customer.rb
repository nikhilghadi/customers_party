class Customer
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :user_id, :integer
  attribute :name, :string
  attribute :latitude, :float
  attribute :longitude, :float

  def initialize(attributes = {})
    super
    validate_attributes
  end

  # calculate distance from given latitude and longitude. considering office latititude and longitude as a default values
  def distance_from(latitude = SOURCE_LATITUDE, longitude = SOURCE_LONGITUDE)
    DistanceCalculator.new.calculate_distance(self, latitude, longitude)
  end

  private

  def validate_attributes
    raise ArgumentError, "Missing required attributes" unless user_id && name && latitude && longitude
  end
end
