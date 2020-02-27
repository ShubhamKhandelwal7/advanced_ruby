require 'net/http'
require 'json'

url = 'https://bitbucket.org/skhandelwal7/jquery/raw/f29b0196c18a6b9f9742bb9321ae93e194918746/exercises/data/specials.json'

user = "{user: {
  name: 'Bob',
  email: 'bob@example.com'
     }
}"

def get_response_json(uri)
  JSON.parse(Net::HTTP.get(uri))
end

def post_response_json(uri, user)
  Net::HTTP.post(uri, user)
end
begin
  uri = URI(url)
  response = get_response_json(uri)
  puts response
  posted_resp = post_response_json(uri, user)
  p posted_resp
  # response = get_response_json(uri)
  # puts response
  # puts response['monday']['title']
rescue StandardError => e
  puts e.class, e.message
end