json.array!(@readings) do |reading|

	if reading.original_date.present?
	  json.period reading.original_date.strftime("%Y-%m-%d")
	else
		json.period reading.created_at.strftime("%Y-%m-%d")
	end

	json.battle_id reading.battle_id
	
	json.amount reading.amount

	json.set! 'user', reading.user.name
end
