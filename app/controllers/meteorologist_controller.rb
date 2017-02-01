require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @no_spaces = @street_address.gsub(" ", "")
    @new_address = @street_address.gsub(" ", "+")
    @url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@new_address}"
    @parsed_data = JSON.parse(open(@url).read)

    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"]
    @weatherurl = "https://api.darksky.net/forecast/d5625fe2e40ae929fd1f31ea2269f7af/#{@latitude},#{@longitude}"
    @weather_parsed_data = JSON.parse(open(@weatherurl).read)

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================


    @current_temperature = @weather_parsed_data["currently"]["temperature"]

    @current_summary = @weather_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = @weather_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = @weather_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = @weather_parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
