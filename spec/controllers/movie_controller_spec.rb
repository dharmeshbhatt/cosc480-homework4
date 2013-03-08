require "spec_helper"

describe MoviesController do
  describe "add director to existing movie" do
    it "should call update_attributes and redirect to show" do
      @movie = mock(Movie, :title => "Black Dynamite", :director => "Shakespeare",
                                         :release_date => "10-Mar-1990",:id => 1) 
      Movie.stub!(:find).with("1").and_return(@movie)
      @movie.stub!(:update_attributes!).and_return(true)
      put :update, {:id => "1"}
      response.should redirect_to(movie_path(@movie))
      end
  end
end
