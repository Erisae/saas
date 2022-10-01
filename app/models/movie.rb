class Movie < ActiveRecord::Base
  def self.all_ratings
    # groups = self.all.group_by{|o| :rating} # o's rating
    # return groups.keys
    all_ratings = self.pluck :rating
    return all_ratings.uniq
  end 

  def self.with_ratings(ratings_list)
    if ratings_list == nil
      return self.all
    else 
      return self.where(rating: ratings_list)# User.where(name: ["Alice", "Bob"])
    end
  end

end

