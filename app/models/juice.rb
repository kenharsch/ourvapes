class Juice < Product
	has_one :details, class_name: 'JuiceDet', dependent: :delete
	delegate_details :nicotine_in_ml, to: :details
	default_scope {joins(:details)}
end
