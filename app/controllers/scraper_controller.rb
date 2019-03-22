require 'rest-client'

class ScraperController < ApplicationController
  #skip_before_action :verify_authenticity_token, only: [:winners]
  #skip_before_action :authenticate_user!, only: [:winners]

  # GET winners
  def winners
    page = Nokogiri::HTML(RestClient.get "https://stats.ncaa.org/contests/scoreboards",
                              {params: {season_division_id: 16700, game_date: params[:date].to_date,
                                        conference_id: 0}})
    winners = []
    winner_tds = page.css("td.winner_background").css('a')
    winner_tds.each do |td|
      winners<< td.text
    end
    render json: { winners:  winners }.to_json
  end

end
