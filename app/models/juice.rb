class Juice < Product
	delegate_details :nicotine_in_ml, to: 'JuiceDet'
end
