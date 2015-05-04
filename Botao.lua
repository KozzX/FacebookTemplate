local widget = require( 'widget' )

function new( texto,y )
	local options = {
		id=texto,
		x=display.contentCenterX,
		y=display.contentHeight / 100 * y,
		width=display.contentWidth / 100 * 60,
		height=display.contentHeight / 100 * 10,
		label=texto,
		labelColor = { default={0,0,0}, over={0,0,0} },
		emboss=true,
		fontSize=20,
		labelAlign="center",
		font=native.systemFont,
		shape="roundedRect",
		cornerRadius=10,
		fillColor = { default={0.5,0.5,0.5}, over={0.3,0.3,0.3} },
		strokeColor = { default={0,0,0}, over={0,0,0} },
		strokeWidth = 3
	}
	local botao = widget.newButton( options )
	botao.anchorX = 0.5
	botao.anchorY = 0.5
	--botao.alpha = 0.7
	botao:scale( 0, 0 )
	transition.scaleTo( botao, {xScale=1,yScale=1,time=100} )

	return botao
end

return {
	new = new
}