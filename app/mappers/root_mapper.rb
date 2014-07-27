class RootMapper < Yaks::Mapper
  link 'users', '/users'
  link 'user', '/users/{user_id}', expand: false
end
