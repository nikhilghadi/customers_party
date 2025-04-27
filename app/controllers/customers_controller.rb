class CustomersController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, only: [:upload] if Rails.env.test?
  before_action :validate_file, only: [:upload]

  def index

  end

  # upload file and retuns custmer within given distance
  def upload

    distance = (params[:distance].to_i)
    distance = distance == 0 ? INVITE_DISTANCE_KM : distance
    # giving ability to add distance to the user if user dont add the distance the consider 100 km as a default value
   
    # Can add timeout if file is taking to much time to parse and filter
   
    # We can also rate limit this API so someone cant overload our server.

    
    file_processor = FileProcessor.new(@file)
    all_customers = file_processor.parse_customers

    @customers = CustomerFilter.new(all_customers, distance).filter.sort_by(&:user_id)

    respond_to do |format|
      format.turbo_stream {
          render turbo_stream: turbo_stream.update("customers_table", partial: "customers/customers_table", locals: { customers: @customers, distance: distance })
      }
      format.json { render json: @customers }
    end
  end

  private

  # validating uploaded file
  def validate_file
    @file = params[:file]
     p "FILEEv#{@file}"
    unless @file&.respond_to?(:read)
      return render_error("Please upload a file")
    end

    if @file.content_type != "text/plain"
      return render_error("Only .txt files are allowed.")
    end
  
    if @file.size > 3.megabyte
      return render_error("File size exceeds the maximum limit (3MB).")
    end
  end
end
