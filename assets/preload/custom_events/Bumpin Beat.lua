-- bpforest

function onEvent(name, v1, v2)
	if name == "Bumpin Beat" then
		if v1 ~= "" then
			v1 = tonumber(v1)
			setProperty("camZoomingMult", tonumber(v1))
		end

		if v2 ~= "" then
			v2 = tonumber(v2)
			setProperty("bumpinBeat", tonumber(v2))
		end
	end
end