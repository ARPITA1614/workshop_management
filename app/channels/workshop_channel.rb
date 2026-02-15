class WorkshopChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "Subscribed to workshop_#{params[:workshop_id]}"
    stream_from "workshop_#{params[:workshop_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
