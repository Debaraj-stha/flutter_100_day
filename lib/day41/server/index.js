const express = require("express");
const app = express();
const server = require("http").createServer(app);
const io = require("socket.io")(server);

const PORT = 8000;
app.get("/", (req, res) => {
  return res.send("working");
});
var client_id = "CLIENT_ID";
var redirect_uri = "http://localhost:8888/callback";

var ClientId = "ba383d920c414fe894b7d8458db221ea";
var ClientSecret = "ffd70c9c29824022b7588e181e1d73ef";

app.get("/login", function (req, res) {
  var state = 16;
  var scope = "user-read-private user-read-email";

  res.redirect(
    `https://accounts.spotify.com/authorize?response_type:code&client_id:${ClientId}scope: ${scope}redirect_uri: ${redirect_uri}state: ${state}`
  );
});

io.on("connection", (socket) => {
  console.log(socket.id);
  socket.broadcast.emit("connection");
  socket.on("disconnect", () => {
    socket.on("disconnect", () => {
      socket.broadcast.emit("user-disconnected");
    });
    console.log(`disconnected ${socket.id}`);
  });
  socket.on("notify", (data) => {
    socket.broadcast.emit("notify");
  });
});
server.listen(PORT, () => {
  console.log(`listening on port ${PORT}`);
});
