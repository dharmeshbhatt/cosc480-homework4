# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

     when /^the (RottenPotatoes )?home\s?page$/ then '/movies'
     when /^the movies page$/ then '/movies'
     when /^the Create New Movie page$/ then '/movies/new'
     when /^the (edit|details) page for "(.*)"/i 
      movie = Movie.where(["title = :m", {:m => $2}]).first
      if !movie.nil?
        if $1 == "edit"
          edit_movie_path(movie)
        else
          movie_path(movie)
        end
      end
      
     when /^the Similar Movies page for "(.*)"/i
      movie = Movie.where(["title = :m", {:m => $1}]).first
      if !movie.nil?
        same_director_path(movie)
      end
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
