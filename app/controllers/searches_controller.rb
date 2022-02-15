class SearchesController < ApplicationController
  
  def search
    #検索ワードを取得
    @range = params[:range]
    
    if @range == 'Genre'
      @genres = Genre.looks(params[:word])
    else
      @rooms = Room.looks(params[:word])
    end
  end
  
end
