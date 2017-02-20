class User < ActiveRecord::Base
	has_many :package
	has_one :sucursal

	
end
