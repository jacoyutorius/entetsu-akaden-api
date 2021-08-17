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

def stations
  [
    'shinhamamatsu',
    'daiichi-dori',
    'enshubyoin',
    'hachiman',
    'sukenobu',
    'hikuma',
    'kamijima',
    'jidosyagakkomae',
    'saginomiya',
    'sekishi',
    'nishigasaki',
    'komatsu',
    'hamakita',
    'misonochuokoen',
    'kobayashi',
    'shibamoto',
    'gansuiji',
    'nishikajima'
  ]
end

get '/' do
  {
    message: 'hello world!'
  }.to_json
end

get '/info/:station' do
  raise 'Station is not defined.' unless stations.include? params['station']

  id = "#{params[:station]}-#{version}"
  ret = client.execute_statement({
    statement: "select * from Timetable where id='#{id}' and sk='info'"
  })

  record = ret.items.first

  {
    **record.except('id', 'sk'),
    version: record['version'].to_i
  }.to_json
end

get '/fare/:station/:to' do
  raise 'Station is not defined.' unless stations.include? params['station']
  raise 'Where to is not defined.' unless stations.include? params['to']

  id = "#{params[:station]}-#{version}"
  ret = client.execute_statement({
    statement: "select * from Timetable where id='#{id}' and sk='#{params[:to]}'"
  })

  record = ret.items.first

  {
    **record.except('id', 'sk'),
    version: record['version'].to_i
  }.to_json
end

get '/timetables/:station/:detection/:week' do
  pp stations.include? params['station']
  raise 'Station is not defined.' unless stations.include? params['station']
  raise 'Detection is not defined.' unless %w(upto downto).include? params['detection']
  raise 'Weektype is not defined.' unless %w(weekday weekend).include? params['week']

  key = "#{params[:station]}-#{params[:detection]}-#{params[:week]}-#{version}"
  ret = client.execute_statement({
    statement: "select * from Timetable where id='#{key}'"
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

not_found do
  <<~HTML
    <h2>Not found</h2>
  HTML
end
