class AdminSetupController < ApplicationController
    def check
            render plain: AdminUser.pluck(:email)
    end
end