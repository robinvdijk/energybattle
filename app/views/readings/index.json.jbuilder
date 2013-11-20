json.array!(@readings) do |reading|
  json.extract! reading, :amount, :user_id, :battle_id, :created_at, :original_date
  
end
