require 'hobbit'
require 'hobbit/contrib'
require 'data_mapper'
require 'rack/protection'
require 'rack-flash'


require_relative 'custom-hobbit'
require_relative 'data_mapper_setup'

class Server < Hobbit::Base
  include Hobbit::Mote
  include Hobbit::Session
  use Rack::Session::Cookie, secret: SecureRandom.hex(64)
  use Rack::Protection

  get '/' do
    render 'index', user: current_user, errors: get_errors, feed: get_feed
  end

  get '/users/new' do
    render 'usercreation', user: current_user, errors: get_errors
  end

  post '/users' do
    me = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
    if me.save
      session[:user_id] = me.id
      redirect '/'
    else
      log_errors(me)
      render 'usercreation', user: me, errors: get_errors
    end
  end

  get '/newidea' do
    render 'ideasubmission', user: current_user, errors: get_errors
  end

  post '/submit' do
    new_idea = ProjectIdea.new(title: params[:title], content: params[:content], user_id: current_user.id)
    if new_idea.save
      redirect '/'
    else
      log_errors(new_idea)
      puts "!! #{get_errors}"
      render 'ideasubmission', user: current_user, errors: get_errors
    end
  end

  get '/login' do
    render 'loginpage', user: current_user, errors: get_errors
  end

  post '/login' do
    me = User.first(username: params[:username]) if params[:username]
    if me
      session[:user_id] = me.id
      redirect '/'
    else
      render 'loginpage', user: current_user, errors: get_errors
    end
  end

  get '/logout' do
    session[:user_id] = nil
    render 'logoutpage', user: current_user, errors: get_errors
  end


  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
    # Can I get away with ||= nil?
    @current_user ||= User.new
  end

  def log_errors(object)
    object.errors.keys.each do |key|
      if error_hash.has_key?(key)
        get_errors << error_hash[key]
      else
        get_errors << object.errors[key].first
      end
    end
  end

  def get_errors
    @errors ||= []
  end

  def get_feed
    ProjectIdea.all
  end

  def error_hash
    {username: "That username is taken", password: "Passwords did not match"}
  end


end
