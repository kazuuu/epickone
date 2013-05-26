# RVM

# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'default'
set :rvm_type, :user

# Bundler

require "bundler/capistrano"

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

namespace :db do
  desc "Snapshots production db and dumps into local development db"
  task :pull, roles: :db, only: { primary: true } do
    # adjust prod_config to point to your database.yml
    prod_config = capture "cat #{shared_path}/config/database.yml"

    prod = YAML::load(prod_config)["production"]
    dev  = YAML::load_file("config/database.yml")["development"]
    dump = "/tmp/#{Time.now.to_i}-#{application}.psql"

    run %{pg_dump -x -Fc #{prod["database"]} -f #{dump}}
    get dump, dump
    run "rm #{dump}"

    system %{dropdb #{dev["database"]}}
    system %{createdb #{dev["database"]} -O #{dev["username"]}}
    system %{pg_restore -O -U #{dev["username"]} -d #{dev["database"]} #{dump}}
    system "rm #{dump}"
  end
end

