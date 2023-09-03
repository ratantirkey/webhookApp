class WebhookDataController < ApplicationController
  skip_before_action :verify_authenticity_token # For simplicity, disable CSRF protection

  def index
    @webhookdata_new = WebhookData.new

  end

  def create
    data = WebhookData.new(webhook_data_params)

    if data.save
      data.notify_third_parties(request)
      render json: { message: 'Data created successfully' }, status: :created
    else
      render json: { errors: data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    data = WebhookData.find(params[:id])

    if data.update(webhook_data_params)
      data.notify_third_parties(request)
      render json: { message: 'Data updated successfully' }
    else
      render json: { errors: data.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def webhook_data_params
    params.require(:webhook_data).permit(:name, :data)
  end

  private



  # def third_party_endpoints
  #   [
  #     'http://third-party-api-1.com/endpoint',
  #     'http://third-party-api-2.com/endpoint'
  #   # Add more endpoints as needed
  #   ]
  # end
  #
  # def notify_third_parties(data)
  #   third_party_endpoints.each do |endpoint|
  #     response = Faraday.post(endpoint, json: { name: self.name, data: self.data })
  #     if response.success?
  #       p 'API Successfully Received'
  #     else
  #       p "API Failed: #{response.status} #{response.body}"
  #     end
  #     # Handle response or errors if needed
  #   end
  # end
end
