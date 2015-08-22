module Lita
  module Handlers
    class Pingpong < Handler
      route(/^ping/, :pong, command: true, help: {
        "ping" => "Replies back with pong."
      })

      Lita.register_handler(self)


      def pong response
        response.reply "pong"
      end

    end
  end
end
