json.array!(@readings) do |reading|
  json.extract! reading, :amount, :created_at, :original_date
  
end
