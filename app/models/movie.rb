class Movie < ActiveRecord::Base
  def self.all_ratings
    return self.group("Rating")
  def self.with_ratings(ratings_list)
    if ratings_list == nil
      return self.all
    else 
      return self.where(Rating: ratings_list)# User.where({ name: ["Alice", "Bob"]})
    end
  end

end

