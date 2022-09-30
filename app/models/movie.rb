class Movie < ActiveRecord::Base
  def self.all_ratings
    groups = self.all.group_by{|line| line.Rating}
    return groups.keys
  end 

  def self.with_ratings(ratings_list)
    if ratings_list.length == 0 #nil
      return self.all
    else 
      return self.where("Rating": ratings_list)# User.where(name: ["Alice", "Bob"])
    end
  end

end

