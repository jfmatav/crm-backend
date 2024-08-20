class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  ActiveStorage::Current.url_options = { host: "https://www.example.com" }
end
