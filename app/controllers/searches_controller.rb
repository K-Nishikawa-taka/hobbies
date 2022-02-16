class SearchesController < ApplicationController
  
  def search
    #検索ワードを取得
    @range = params[:range]
    
    if @range == 'Genre'
      @genres = Genre.looks(params[:key_word])
    else
      @rooms = Room.looks(params[:key_word])
    end
  end
  
end
