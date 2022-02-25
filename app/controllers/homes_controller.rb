class HomesController < ApplicationController

  def top
    @genre_ranks = Genre.find(FavoriteGenre.group(:genre_id).limit(5).order('count(genre_id) desc').pluck(:genre_id))
    @room_ranks = Room.find(FavoriteRoom.group(:room_id).limit(5).order('count(room_id) desc').pluck(:room_id))
  end

end
