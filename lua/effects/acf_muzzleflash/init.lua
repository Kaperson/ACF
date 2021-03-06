
   
 /*--------------------------------------------------------- 
    Initializes the effect. The data is a table of data  
    which was passed from the server. 
 ---------------------------------------------------------*/ 
 function EFFECT:Init( data ) 
	
	local Gun = data:GetEntity()
	local Sound = Gun:GetNWString( "Sound" )
	local Propellant = data:GetScale()
	local ReloadTime = data:GetMagnitude()
	local Attachment = math.Round(data:GetRadius())
	if Attachment == 0 then Attachment = nil end
	
	local Class = Gun:GetNWString( "Class" )
	local RoundType = ACF.IdRounds[data:GetSurfaceProp()]
		
	if Gun:IsValid() then
		if Propellant > 0 then
			local SoundPressure = (Propellant*1000)^0.5
			sound.Play( Sound, Gun:GetPos() , math.Clamp(SoundPressure,75,255), math.Clamp(100,15,255))
			sound.Play( Sound, Gun:GetPos() , math.Clamp(SoundPressure,75,255), math.Clamp(100,15,255))
			sound.Play( ACF.Classes["GunClass"][Class]["soundDistance"], Gun:GetPos() , math.Clamp(SoundPressure,75,255), math.Clamp(100,15,255))
			sound.Play( ACF.Classes["GunClass"][Class]["soundNormal"], Gun:GetPos() , math.Clamp(SoundPressure,75,255), math.Clamp(100,15,255))
	
	

			local Muzzle = Gun:GetAttachment( Attachment or Gun:LookupAttachment( "muzzle" ) ) or {["Pos"] = Gun:GetPos(), ["Ang"] = Gun:GetAngles()}
			ParticleEffect( ACF.Classes["GunClass"][Class]["muzzleflash"], Muzzle.Pos, Muzzle.Ang, Gun )
			Gun:Animate( Class, ReloadTime, false )
		else
			Gun:Animate( Class, ReloadTime, true )
		end
	end
	
 end 
   
   
/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
	return false
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render()
end