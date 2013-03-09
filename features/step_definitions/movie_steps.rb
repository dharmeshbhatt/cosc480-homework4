# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.#
    new_movie = Movie.create!(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  body = page.body().downcase
  body.index(e1.downcase) < body.index(e2.downcase)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
   rating_list.split(",").each do |rating|
      rating = rating.strip()
      if uncheck == nil 
        step %{I check "ratings_#{rating}"}
      else  
        step %{I uncheck "ratings_#{rating}"}
      end 
   end
end

Then /I should see all of the movies/ do
  # first row has the headings 
  rows = page.all("#movies tr").size - 1
  rows.should == Movie.count()
end


Then /The director of "(.*)" should be "(.*)"/i do |movie, director|
  Movie.find_by_title(movie).director == director
end
