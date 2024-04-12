function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'black' then
		if direction == 0 then
			cameraShake('camGame', 0.02, 0.02)
		end
		if direction == 1 then
			cameraShake('camGame', 0.02, 0.02)
		end
		if direction == 2 then
			cameraShake('camGame', 0.02, 0.02)
		end
		if direction == 3 then
			cameraShake('camGame', 0.02, 0.02)
		end
	end
end
