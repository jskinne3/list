use Rack::Static

app = proc do |env|
  req = Rack::Request.new(env)
  File.open('list.txt', 'a'){|f| f << "\n#{req.params["new"]}"} if req.params["new"]
  items = File.open('list.txt')
  page = "<html><body><h1>list</h1><ul>#{items.map{|i| "<li>#{i}</li>"}.join}</ul><form><textarea name=\"new\"></textarea><br/><input type=\"submit\" value=\"add\"></body></html>"
  [ 200, {'Content-Type' => 'text/html'}, [page] ]
end

run app