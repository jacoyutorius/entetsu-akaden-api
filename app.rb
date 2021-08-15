require 'aws-sdk-dynamodb'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/cors'
require 'json'

set :bind, '0.0.0.0'
set :port, 80
set :allow_origin, '*'
set :allow_methods, 'GET'
set :allow_headers, 'content-type'

client_params = { region: 'ap-northeast-1' }
client_params[:endpoint] = 'http://dynamo-admin:8002' unless ENV.key?('COPILOT_ENVIRONMENT_NAME')
client = Aws::DynamoDB::Client.new(client_params)

def version
  Time.now.localtime.year
end

get '/' do
  {
    message: 'hello world!'
  }.to_json
end

get '/info/:station' do
  ret = client.execute_statement({
    statement: "select * from Timetable where id='#{params[:station]}' and sk='info' and version=#{version}"
  })

  record = ret.items.first

  {
    **record.except('sk'),
    version: record['version'].to_i
  }.to_json
end

get '/fare/:station/:to' do
  ret = client.execute_statement({
    statement: "select * from Timetable where id='#{params[:station]}' and sk='#{params[:to]}' and version=#{version}"
  })

  record = ret.items.first

  {
    **record.except('id', 'sk'),
    version: record['version'].to_i
  }.to_json
end

get '/timetables/:station/:detection/:week' do
  key = "#{params[:station]}-#{params[:detection]}-#{params[:week]}"

  ret = client.execute_statement({
    statement: "select * from Timetable where id='#{key}' and version=#{version}"
  })

  ret.items.map do |row|
    {
      version: row['version'].to_i,
      formation: row['formation'].to_i,
      detection: row['detection'],
      time: row['sk'],
      type: row['type']
    }
  end.to_json
end
