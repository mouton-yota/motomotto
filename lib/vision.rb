require 'base64'
require 'json'
require 'net/https'

module Vision
  class << self
    def get_image_data(image_file)
      # APIのURL作成
      host = ""
      if Rails.env.development?
      host = "http://localhost:3000"
      else if Rails.env.prodcution?
        host = "http://173.44.23.42"
      end
      api_url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}"
      # 画像をbase64にエンコード
      base64_image = Base64.encode64(open("#{host}#{Rails.application.routes.url_helpers.rails_blob_path(image_file)}").read)
      # base64_image = Base64.encode64(open("#{Rails.root}/public/uploads/#{image_file.id}").read)

      # APIリクエスト用のJSONパラメータ
      params = {
        requests: [{
          image: {
            content: base64_image
          },
          features: [
            {
              type: 'LABEL_DETECTION'
            }
          ]
        }]
      }.to_json

      # Google Cloud Vision APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)

      # APIレスポンス出力
      JSON.parse(response.body)['responses'][0]['labelAnnotations'].pluck('description').take(3)
    end
  end
end