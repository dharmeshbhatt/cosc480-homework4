require "spec_helper"

describe MoviesController do
  describe "add director to existing movie" do
    it "should call update and redirect to movies" do
      @movie = mock(Movie, :title => "The Social Network", :director => "David Fincher",
                                         :release_date => "31-Oct-2009",:id => 0) 
      Movie.stub!(:find).with("0").and_return(@movie)
      @movie.stub!(:update_attributes!).and_return(true)
      put :update, {:id => "0"}
      response.should redirect_to(movie_path(@movie))
      end
  end

  describe "sort by title" do
    it "should sort the movies by title" do
      get :index, {:sort => "title"}
      session[:sort].should == "title"
    end
  end
  
  describe "sort by release date" do
    it "should sort the movies by release date" do
      get :index, {:sort => "release_date"}
      session[:sort].should == "release_date"
    end
  end
  
  describe "" do
  end
end
