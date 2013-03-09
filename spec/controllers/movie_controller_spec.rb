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
  
  describe "restrict by ratings" do
    it "should only show movies with selected ratings" do
      get :index, {:ratings => ["G", "PG"]}
      session[:ratings].should == ["G", "PG"]
    end
  end
  
  describe "create a new movie" do
    it "should be able to create a new movie and redirect to movies" do
      post :create, {:title => "A Clockwork Orange", :director => "Stanley Krubrick", 
      "release_date" => "25-Oct-1978", :id => "3"}
      response.should redirect_to(movies_path)
      
    end
  end

  describe "delete a movie" do
    it "should delete the correct movie and redirect to movies" do
      @movie = mock(Movie, :title => "The Hobbit", :rating => "G", :id =>"2")
      Movie.stub!(:find).with("2").and_return(@movie)
      @movie.should_receive(:destroy)
      delete :destroy, {:id => "2"}
      response.should redirect_to(movies_path)
    end
  end

  describe "create a movie" do
    it "should create a new movie and redirect to the movies" do
      post :create, {:title => "Hello World!", :director => "Dharmesh Bhatt", :id => 0}
      response.should redirect_to(movies_path)
    end
  end
  
  describe "movies with same director" do
    it "should find movies with the same director" do
      movie_1 = mock(Movie, :title => "The Departed", :director => "Martin Scorcese", :id => "0")
      movie_2 = mock(Movie, :title => "Taxi Driver", :director => "Martin Scorcese", :id => "1")
      Movie.stub!("find").with("0").and_return(movie_1)
      Movie.stub!("find_all_by_director").with("Martin Scorcese").and_return([movie_2, movie_1])
      {:get => same_director_path("0")}.should route_to(:controller => "movies", :action => "same_director", :id => "0")

    end
  end
end
