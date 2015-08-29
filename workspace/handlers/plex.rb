module Lita
  module Handlers
    class PlexControl < Handler
      PLEX_HOST = ENV['PLEX_HOST']
      PLEX_PORT = ENV['PLEX_PORT']
      PLEX_CLIENT_NAME = ENV['PLEX_CLIENT'] || 'flashpoint'

      if PLEX_HOST and PLEX_PORT
        Lita.register_handler(self)

        PLEX_SERVER = Plex::Server.new PLEX_HOST, PLEX_PORT
        PLEX_MOVIES = PLEX_SERVER.library.sections.find {|s| s.type == 'movie'}
        PLEX_SHOWS = PLEX_SERVER.library.sections.find {|s| s.type == 'show'}
      else
        STDERR.puts 'Plex environment vars not set, Plex handler disabled'
      end

      route(/^plex search\s+(.+)/, :search, command: true, help: {
        'plex search QUERY' => 'Finds movies and TV shows matching the query.'
      })

      route(/^plex list/, :list, command: true, help: {
        'plex list' => 'Lists all movies and TV shows.'
      })

      route(/^plex movie\s+(.+)/, :play_movie, command: true, help: {
        'plex movie NAME' => 'Plays the named movie.'
      })

      def find_movie query
        FuzzyMatch.new(PLEX_MOVIES.all, read: :title).find query
      end

      def find_show query
        FuzzyMatch.new(PLEX_SHOWS.all, read: :title).find query
      end

      def get_client
        p PLEX_SERVER.clients
        p PLEX_CLIENT_NAME
        PLEX_SERVER.clients.find {|c| c.name == PLEX_CLIENT_NAME }
      end

      def search request
        query = request.matches[0][0]

        movie = find_movie query
        show = find_show query

        unless movie or show
          request.reply "No results."
          return
        end

        resp = []

        if movie
          resp.push "Movie: #{movie.title}"
        end

        if show
          resp.push "Show: #{show.title}"
        end

        request.reply resp.join("\n")
      end

      def list request
        resp = "MOVIES:\n\n"

        PLEX_MOVIES.all.each do |movie|
          resp += "#{movie.title}\n"
        end

        resp += "\nSHOWS:\n\n"

        PLEX_SHOWS.all.each do |show|
          resp += "#{show.title}\n"
        end

        request.reply resp
      end

      def play_movie request
        query = request.matches[0][0]
        client = get_client

        unless client
          request.reply 'Client not connected'
          return
        end

        movie = find_movie query

        unless movie
          request.reply 'No such movie'
          return
        end

        client.play_media(movie)

        request.reply "Playing: #{movie.title}"
      end

    end
  end
end
