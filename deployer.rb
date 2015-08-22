require 'sinatra'
require 'open3'

enable :lock
set :port, 2001
set :bind, '127.0.0.1'

get '/*/*' do |user, repo|
  output, status = Open3.capture2e(File.expand_path('deploy'), user, repo)

  content_type 'text/plain'
  if status == 0
    return output
  else
    "*** Ошибка ***\n\n#{output}"
  end
end

