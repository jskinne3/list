use Rack::Static

app = proc do |env|
  req = Rack::Request.new(env)
  lines = File.readlines("list.txt")
  lines.unshift(req.params["new"]) if req.params["new"]
  lines.delete_at(req.params["x"].to_i) if req.params["x"]
  File.open("list.txt", 'w'){|f| f.puts lines} if req.params["new"] || req.params["x"]
  page = "<!doctype html><html><body style=\"font-family:sans-serif;\"><form><input name=\"new\"> <input type=\"submit\" value=\"add\"></form><br/><table>#{lines.map.with_index{|t,i| "<tr><td>#{t.strip}</td><td><a href=\"?x=#{i}\">x</a></td></tr>"}.join}</table></body></html>"
  [ 200, {'Content-Type' => 'text/html'}, [page] ]
end

run app
