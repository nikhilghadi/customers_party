class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
 
  def render_error(message)
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.update(
          "error_frme", 
          partial: "shared/error_message",
          locals: { message: message }
        )
      }
      format.json { render json: { error: message }, status: :unprocessable_entity }
    end
  end
end
