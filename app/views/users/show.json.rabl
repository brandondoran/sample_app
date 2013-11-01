object @user
attributes :id, :email, :created_at, :updated_at, :admin

node(:microposts_count)     { |user| user.microposts.count }
node(:followed_users_count) { |user| user.followed_users.count }
node(:followers_count) { |user| user.followers.count }

child :followed_users => :followed_users do
  attributes :id, :content, :created_at, :updated_at
end

child :followers => :followers do
    attributes :id, :content, :created_at, :updated_at
end