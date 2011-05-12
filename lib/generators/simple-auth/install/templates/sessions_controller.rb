class SessionsController < ApplicationController
  unloadable

  skip_before_filter :authenticate, :only => [:new, :create, :destroy]
  protect_from_forgery :except => :create

  def new
    render :template => 'sessions/new'
  end

  def create
    @user = authenticate(params)
    if @user.nil?
      flash[:success] = translate('sessions.create.success', :default => 'Signed in')
      render :action => 'new', :status => :unauthorized
    else
      flash[:failure] = translate('sessions.create.failure', :default => 'Bad email or password')
      sign_in(@user)

      redirect_back_or '/'
    end
  end

  def destroy
    sign_out
    flash[:success] = translate('sessions.destroy.success', :default => 'Signed out')
    redirect_to(url_after_destroy)
  end
end
