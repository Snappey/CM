
function draw.OutlinedRect(x, y, w, h, col)
	surface.SetDrawColor( col )
	surface.DrawOutlinedRect( x, y, w, h )
end

function draw.OutlinedBox(x, y, w, h, colbox, colout)
	draw.RoundedBox( 0, x, y, w, h, colbox ) 
	surface.SetDrawColor( colout )
	surface.DrawOutlinedRect( x, y, w, h )
end
