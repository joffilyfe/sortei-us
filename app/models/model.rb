class User < ActiveRecord::Base
  validates_presence_of :name
end

class Count < ActiveRecord::Base
  validates_presence_of :counter
end