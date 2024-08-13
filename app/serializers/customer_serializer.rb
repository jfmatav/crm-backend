class CustomerSerializer < ActiveModel::Serializer
  attributes :name, :surname, :cx_id, :photo_url, :created_by_id, :updated_by_id

  def photo_url
    ActiveStorage::Current.url_options = {host: "https://www.example.com"}
    object.photo&.url
  end
end