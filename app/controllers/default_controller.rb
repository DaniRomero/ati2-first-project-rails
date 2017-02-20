class DefaultController < ApplicationController
	layout 'application_footer.html.haml'
	def index
		@vs = VariablesSistema.last
		if session[:logueado]
			if session[:type] == 0 then
				redirect_to controller: :client , action: :index
			end
			if session[:type] == 1 then
				redirect_to controller: :employee , action: :index
			end
			if session[:type] == 2 then
				redirect_to controller: :admin , action: :index
			end
			return
		end
	end

	def nvl( s )
	    number = s.to_i
	    number = 0 if (number.to_s != s)
	    return number
	end

	def calculadora
		
		vs = VariablesSistema.last
		identificador = "{ \"id\" : " + "\"" + vs.id.to_s + "\"" + ", "
		constante = "\"constante\" : " + "\"" + vs.const.to_s + "\"" + ", "
		porcentaje = "\"porcentaje\" : " + "\"" + vs.k.to_s + "\"" + "} "
		retorno = identificador + constante + porcentaje
		p retorno
		respond_to do |format|
			format.json {render json:retorno}
		end
	end

	def login
	    reset_session
	    
	    email = params[:email]
	    user = User.where(email: email)
	    if user.size==0
	    	retorno = "ne"
	    	respond_to do |format|
				format.json {render json:retorno}
			end
	    	return
	    end
	    begin
			user = User.where(email: email)
		rescue ActiveRecord::RecordNotFound => e
			user = nil
		end
		if (user==nil)
			retorno = "ne"
	    	respond_to do |format|
				format.json {render json:retorno}
			end
	    	return
	    end
	    p "break 1"
	    clave = Digest::MD5.hexdigest(params[:password])
	   

	    if user && clave == user[0].password
	      session[:logueado] = true
	      session[:id] = user[0].id
	      session[:type] = user[0].user_type
	      session[:nombre] = user[0].first_name
	      session[:rol] = user[0].user_type
	      if (user[0].sucursal_id != nil)
	      	session[:sucursal] = user[0].sucursal_id
	      else
	      	session[:sucursal] = -1
	      end
	      	retorno = "true"
	    	respond_to do |format|
				format.json {render json:retorno}
			end
	    else
	    	retorno = "cn"
	    	respond_to do |format|
				format.json {render json:retorno}
			end
	    end
  	end

  	def new 
  		@user = User.new
  	end

  	def registro
  		clave = Digest::MD5.hexdigest(params[:clave])
  		p params[:email]
  		pruebaEmail = User.where(email:params[:email]).take
  		p pruebaEmail
  		if pruebaEmail
  			retorno = "ee"
  			respond_to do |format|
  				format.json {render json:retorno}
  			end
  			return
  		end

  		@newuser = User.create(password:clave,
  		email:params[:email],
  		first_name:params[:nombre],
  		last_name:params[:apellido],
  		age:params[:edad],
  		cedula:params[:cedula],
  		phone:params[:telefono],
  		user_type:"0")

  		userReg = User.last

  		if @newuser.save
  			session[:logueado] = true
	        session[:id] = userReg.id
	        session[:type] = 0
	        session[:nombre] = params[:name]
	        ActionCorreo.welcome_email(@newuser).deliver_now
	        retorno = "true"
  			respond_to do |format|
  				format.json {render json:retorno}
  			end
  			return
  		else
  			retorno = "false"
  			respond_to do |format|
  				format.json {render json:retorno}
  			end
  			return
  		end
  	end


  	  # Cambiar contraseña
	def random_alphanumeric(size=8) 
	    chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a #puede contener letras mayusculas y minusculas, ademas de los numeros
	    @clave=(0...size).collect { chars[Kernel.rand(chars.length)] }.join
	    return @clave
	end

  	def cambiar_contrasena
  		user = User.where(email:params[:olvido][:email]).take
  		p user
  		if user
	    	userr = random_alphanumeric
	    	user.password = Digest::MD5.hexdigest(userr)
	    	user.save
	    	ActionCorreo.cambiar_contrasena(user,userr).deliver_now
	    end
		redirect_to controller: :default, action: :index
  	end	


end
