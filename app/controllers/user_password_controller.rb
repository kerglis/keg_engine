class UserPasswordController < ApplicationController

  inherit_resources
  defaults :resource_class => User, :instance_name => 'user'

  before_filter :authenticate_user!
  before_filter :resource

  actions :show, :edit, :update

  def show
    render :edit
  end

  def update
    if resource.errors.empty?
      sign_in(:user, resource)
      respond_with resource, :location => user_path
    else
      respond_with resource
    end
  end

private

  def resource
    @user = current_user
  end

end