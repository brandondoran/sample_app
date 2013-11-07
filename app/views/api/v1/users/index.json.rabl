object false

node(:total) { |u| @users.total_entries }
node(:total_pages) { |u| (@users.total_entries.to_f / @users.per_page).ceil }
node(:page_num) { |u| @users.current_page }

child(@users) do
  extends "api/v1/users/show"
end