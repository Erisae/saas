class Movie < ActiveRecord::Base
  def self.all_ratings
    groups = Movie.group_by{|line| line.Rating}
    return groups.keys
  end 

  def self.with_ratings(ratings_list)
    if ratings_list.length == 0 #nil
      return Movie.all
    else 
      return Movie.where("Rating": ratings_list)# User.where(name: ["Alice", "Bob"])
    end
  end

end

