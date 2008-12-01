class MapsController < ApplicationController
  def show
    @map = Hash.new
    @map[:index] = params[:i]
    @map[:address] = !params[:a].blank? ? params[:a] : '1 Market St., San Francisco, CA'
    @map[:link_address] = params[:al]
  end
end
