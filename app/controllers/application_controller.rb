class ApplicationController < ActionController::Base

    helper_method :log

    def welcome
        if user_signed_in?
            redirect_to plants_path
        else
            render :welcome
        end
    end
    
    private

    # def log
    #     unless user_signed_in?
    #     redirect_to root_path
    #     end
    # end
    
end
