local facebook = require( "facebook" )
local json = require( "json" )

local player = {}

local function facebookListener( event )

    print( "event.name:" .. event.name )  --"fbconnect"
    print( "isError: " .. tostring( event.isError ) )
    print( "didComplete: " .. tostring( event.didComplete ) )
    print( "event.type:" .. event.type )  --"session", "request", or "dialog"    

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
            player.id = response.id
            player.name = response.first_name .. " " .. response.last_name
        end

    elseif ( "dialog" == event.type ) then
        print( "dialog", event.response )
        --handle dialog results here
    end
end


local fbAppID = "000000000000"  --replace with your Facebook App ID

facebook.login( fbAppID, facebookListener, { "user_friends", "email" } )







