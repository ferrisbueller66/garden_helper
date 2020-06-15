class CallbacksController < Devise::OmniauthCallbacksController

    def github
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user

       #alternate way of writing this without custom controller
        # pp request.env['omniauth.auth']
        # session[:name] = request.env['omniauth.auth']['info']['name']
        # session[:omniauth_data] = request.env['omniauth.auth']
        # redirect_to root_path
      end

end
