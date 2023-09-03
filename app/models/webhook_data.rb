class WebhookData < ApplicationRecord
  validates :name, presence: true
  validates :data, presence: true
  # after_save :notify_third_parties

  def notify_third_parties(request)
    begin
      third_party_endpoints = Dotenv.parse('webhook.env').values
      vws = verify_webhook_signature(request)
      third_party_endpoints.each do |endpoint|
        case vws&.dig(:status)
        when :ok
          third_party_endpoints.each do |endpoint|
            response = Faraday.post(endpoint, json: { status: :ok, name: self.name, data: self.data })
            if response.success?
              p "API Successfully Received: #{response.status} #{response.body}"
            else
              p "API Failed: #{response.status} #{response.body}"
            end
          end
        when :unauthorized
          Faraday.post(endpoint, json: vws)
        end
      end
    rescue => ex
      p ex.full_message
    end
  end

  private

  def verify_webhook_signature(request)
    begin
      received_signature = request.headers['X-Signature']
      secret_key = 'your_secret_key' # The secret key shared with the third party

      # Recreate the signature using the secret key and request payload
      computed_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), secret_key, request.body.read)

      # Compare the computed signature with the received signature
      if received_signature == "sha256=#{computed_signature}"
        # Signature is valid, process the webhook request
        return { status: :ok }
      else
        # Invalid signature, reject the request
        return { status: :unauthorized }
      end
    rescue => ex
      p ex.full_message
    end
  end

  def third_party_endpoints
    [
      'http://third-party-api-1.com/endpoint',
      'http://third-party-api-2.com/endpoint'
    # Add more endpoints as needed
    ]
  end

end
