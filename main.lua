-------------------------------------------------------------
-- Coronium Composer
-------------------------------------------------------------
local globals = require( "globals" )
local mc = require( "mod_coronium" )
local facebook = require( "facebook" )
local json = require( "json" )
local Botao = require( 'Botao' )


mc:init({ appId = globals.appId, apiKey = globals.apiKey })

mc.showStatus = true

mc:run( "select", {id="974063519271155"} )
local player = {}


local btnLogin = Botao.new("Login",20)
local btnRequest = Botao.new("Request",30)
local btnLogout = Botao.new("Logout",80)
local btnNome
local btnPlayer

local function facebookListener( event )

    print( "event.name:" .. event.name )  --"fbconnect"
    print( "isError: " .. tostring( event.isError ) )
    print( "didComplete: " .. tostring( event.didComplete ) )
    print( "event.type:" .. event.type )  --"session", "request", or "dialog"
    --"session" events cover various login/logout events
    --"request" events handle calls to various Graph API calls
    --"dialog" events are standard popup boxes that can be displayed

    if ( "session" == event.type ) then
        --options are "login", "loginFailed", "loginCancelled", or "logout"
        if ( "login" == event.phase ) then
            local access_token = event.token
            --code for tasks following a successful login
            local params = { fields = "id,first_name,last_name" }
            facebook.request( "me", "GET", params )
            
        end

    elseif ( "request" == event.type ) then
    	
        print("facebook request")
        if ( not event.isError ) then
            local response = json.decode( event.response )
            
            --local function selectCallback( event )
            --    if #event.result > 0 then
            --        btnNome = Botao.new(event.result[1].nom_jogador,50) 
            --        player.nome = event.result[1].nom_jogador  
            --    else
            --        mc:run( "insert", {username = response.first_name .. " " .. response.last_name, facebookId=response.id} )
                    btnNome = Botao.new(response.first_name .. " " .. response.last_name,50) 
                    player.id = response.id
                    player.nome = response.first_name .. " " .. response.last_name
            --    end
            --end
            --mc:run( "select", {id=response.id}, selectCallback)

        end

    elseif ( "dialog" == event.type ) then
        print( "dialog", event.response )
        --handle dialog results here
    end
end


local fbAppID = "470194229805310"  --replace with your Facebook App ID

btnLogin:addEventListener( "tap", function( )
	facebook.login( fbAppID, facebookListener, { "user_friends", "email" } )
end )

btnRequest:addEventListener( "tap", function ( )
    btnPlayer = Botao.new(player.id .. " " .. player.nome, 60)    	
end )

btnLogout:addEventListener( "tap", function ( )
	facebook.logout( )
end )






