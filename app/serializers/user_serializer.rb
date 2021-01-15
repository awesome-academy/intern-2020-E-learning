class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :birthday, :location, :created_at

  def birthday
    object.birthday.strftime Settings.date_format
  end

  def created_at
    object.created_at.strftime Settings.date_format
  end
end
