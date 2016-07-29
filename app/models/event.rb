class Event < ApplicationRecord

	has_many :approvals, dependent: :destroy
  has_many :users, -> { uniq }, through: :approvals

 	geocoded_by :full_street_address   # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

end
