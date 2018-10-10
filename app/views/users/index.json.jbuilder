json.aaData do
	json.array!(@users) do |user|
	  json.DT_RowId "dt_user_#{user.id}"
	  json.extract! user, :id, :full_name_first_last, :email
	  json.user_url link_to user.full_name_first_last, edit_user_url(user), remote: true
	end
end
