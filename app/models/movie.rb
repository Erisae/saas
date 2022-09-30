class Movie < ActiveRecord::Base
  def self.all_ratings
    return self.group(:ratings)
  def self.with_ratings(ratings_list)
    if ratings_list.length == 0 #nil
      return self.all
    else 
      return self.where(:ratings: ratings_list)# User.where({ name: ["Alice", "Bob"]})
    end
  end

end

