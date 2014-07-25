class UserMapper < Yaks::Mapper
  link :self, '/users/{id}'

  attributes :id, :name, :email, :created_at, :updated_at
end
