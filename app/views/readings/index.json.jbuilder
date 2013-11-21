json.array!(@readings) do |reading|

	if reading.original_date.present?
	  json.period reading.original_date.strftime("%Y-%m-%d")
	else
		json.period reading.created_at.strftime("%Y-%m-%d")
	end

    json.user_id reading.user_id



    json.set! reading.user.name, reading.amount
    json.set! "Mathijs Kingma", reading.amount + 400
end
