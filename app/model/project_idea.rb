class ProjectIdea

  include DataMapper::Resource


  property :id, Serial
  property :title, String, required: true
  property :content, Text, required: true
  property :favorite_count, Integer, default: 0
  belongs_to :user


  def like
    self.favorite_count +=1
  end

  def unlike
    self.favorite_count -= 1
  end




end
