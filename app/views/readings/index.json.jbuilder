json.array!(@readings) do |reading|

	if reading.original_date.present?
	  json.period reading.original_date.strftime("%Y-%m-%d %H:%M")
	else
		json.period reading.created_at.strftime("%Y-%m-%d %H:%M")
	end
	
	json.amount reading.amount
end
