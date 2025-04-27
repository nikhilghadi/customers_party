class CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:upload]
  before_action :validate_file, only: [:upload]

  def index

  end

  # upload file and retuns custmer within given distance
  def upload

    distance = (params[:distance].to_i)
    distance = distance == 0 ? INVITE_DISTANCE_KM : distance
    # giving ability to add distance to the user if user dont add the distance the consider 100 km as a default value
   
   
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
