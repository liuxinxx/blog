require 'grape-swagger'

class ApplicationApi < Grape::API
  content_type :json, 'application/json;charset=UTF-8'
  format :json
  mount V1::Base
end