require 'net/http'
require 'json'

class LoansController < ApplicationController

  def mock_internal_server_error
    render json: { message: "Mock Internal Server Error" }, status: 502
  end

  def access_token
      token = {
          "access_token" => fakeUUID(),
          "expires_in" => 3600,
          "realm" => "Bearer"
      }
      render json: token, status: 200
  end

  def express
      render json: {
        "sid": "EXPRESS",
        "ref" => "SA67SHIJKSPW",
        "status" => "Success"
      }, status: 500
  end

  def b2c

    # callback_url = params[:callback_url]

    # url = URI.parse(callback_url)
    # http = Net::HTTP.new(url.host, url.port)
    # http.use_ssl = (url.scheme == "https")

    data = { "ref" => "SA67SHIJKSPW", "status" => "Success" }
    # request = Net::HTTP::Post.new(url.path, { "Content-Type" => "application/json" })
    # request.body = data.to_json

    # response = http.request(request)

    failed = {
      requestID: "jdgfujve-sdffd-ddss-sfnmjfnkds",
      errorCode: "2001",
      errorMessage: "Failed B2C request"
    }

    success = {
      ConversationID: "conversation-id",
      OriginatorConversationID: "originator-conversation-id",
      ResponseCode: "Response code",
      ResponseDescription: "Response Description"
    }

    status = [true, false].sample

    render json: status ? success : failed, status: status ? 200 : 400 
  end

  def mock_b2c_callback
    ResultType: 0,
    ResultCode: 0,
    ResultDesc: "Result Description",
    OriginatorConversationID: "4fac489f-644f-47c4-bb40-3ccc5dba195c",
    ConversationID: fakeUUID(),
    TransactionID: fakeUUID,
    ResultParameters: {

    },
    ReferenceData: {

    },
  end

  def c2b
      render json: {
          
      }
  end

  def b2b
      render json: {
          
      }
  end

  def fakeUUID()
    "#{Random.srand()}".slice(0, 36)
  end
end
