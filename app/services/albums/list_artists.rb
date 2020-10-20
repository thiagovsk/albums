module Albums
  class ListArtists < ApplicationService
    def	call
      request_artits_api
    end

    private

    def request_artits_api
      url = 'https://run.mocky.io/v3/46ca2011-8b43-47cf-b3d7-4df003d48469/'
      response = Faraday.get(url)
      JSON.parse(response.body)
    rescue StandardError => e
      Rails.logger.info("Fail to comunicate with Albums API, #{e} #{response}")
      []
    end
  end
end
