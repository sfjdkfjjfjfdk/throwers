class User::UsersController < ApplicationController

 def show
   @user = current_user
 end

 def edit
   @user = current_user
 end

 def update
   @user = current_user
   if @user.update(user_params)
     redirect_to  users_infomation_path
   else
     @user = current_user
     render :edit
   end
 end

 private

 def user_params
   params.require(:user).permit(:name, :event, :target, :task)
 end

end
