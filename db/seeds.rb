require 'open-uri'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Activity.delete_all
open("http://dl.dropbox.com/u/48576647/activities.txt") do |activities|
  activities.read.each_line do |activity|
    act=activity.chomp
    Activity.create!(:name => act) 
    end
end  
 
 
Major.delete_all
open("http://dl.dropbox.com/u/48576647/majors.txt") do |majors|
  majors.read.each_line do |major|
    maj=major.chomp
    Major.create!(:name => maj)   
    end
end
 
School.delete_all
open("http://dl.dropbox.com/u/48576647/schools.txt") do |schools|
    schools.read.each_line do |school|
    sch=school.chomp
    School.create!(:name => sch) 
    end
end

  