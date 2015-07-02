use Rack::Static

app = proc do |env|
  lines = IO.readlines("list.txt")
  req = Rack::Request.new(env)
  lines.delete_at(req.params["done"].to_i) if req.params["done"]
  lines.unshift(req.params["new"]) if req.params["new"]
  File.open("list.txt", 'w'){|f| f.puts lines} if req.params["new"] || req.params["done"]
  page = "<!doctype html><html><body><form><input name=\"new\"> <input type=\"submit\" value=\"add\"></form><table>#{lines.map.with_index{|t,i| "<tr><td>#{t.strip}</td><td><a href=\"?done=#{i}\">done</a></td></tr>"}.join}</table></body></html>"
  [ 200, {'Content-Type' => 'text/html'}, [page] ]
end

run app