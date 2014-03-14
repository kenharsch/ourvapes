class Button < Product
	delegate_details :connector, to: 'ButtonDet'
end
