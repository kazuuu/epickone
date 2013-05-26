# RVM

# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'default'
set :rvm_type, :user

# Bundler

require "bundler/capistrano"

# CapistranoDB Task Gem
require 'capistrano-db-tasks'
# if you haven't already specified
set :rails_env, "production"

# if you want to remove the dump file after loading
set :db_local_clean, true

# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
# set :assets_dir, %w(public/assets public/att)
# if you want to work on a specific local environment (default = ENV['RAILS_ENV'] || 'development')
set :locals_rails_env, "development"

# General

set :application, "epickone"
set :user, "ubuntu"

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :copy

set :use_sudo, false

# Git

set :scm, :git
set :repository,  "git@github.com:kazuuu/epickone.git"
set :branch, "master"

# VPS

role :web, "107.22.177.44"
role :app, "107.22.177.44"
role :db,  "107.22.177.44", :primary => true
role :db,  "107.22.177.44"
ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/ec2key"]

# Passenger

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end