# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'moriyamataku@gmail.com', password: '12345678')
tag = Tag.create(name: 'rails')
#questions

#for i in 1..100 do
100.times do |i|

  question = Question.new(
      title: "Railsについて質問です。#{100 - i}",
      body: "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" +
        "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" +
        "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
  )
  question.user = user
  question.tags << tag
  question.save!
end

users = User.create(
  [
    {email: 'user01@gmail.com', password: '12345678'},
    {email: 'user02@gmail.com', password: '12345678'},
    {email: 'user03@gmail.com', password: '12345678'},
    {email: 'user04@gmail.com', password: '12345678'},
    {email: 'user05@gmail.com', password: '12345678'},
    {email: 'user06@gmail.com', password: '12345678'},
    {email: 'user07@gmail.com', password: '12345678'},
    {email: 'user08@gmail.com', password: '12345678'},
    {email: 'user09@gmail.com', password: '12345678'},
    {email: 'user10@gmail.com', password: '12345678'},
    {email: 'user11@gmail.com', password: '12345678'},
    {email: 'user12@gmail.com', password: '12345678'},
    {email: 'user13@gmail.com', password: '12345678'},
    {email: 'user14@gmail.com', password: '12345678'},
    {email: 'user15@gmail.com', password: '12345678'},
    {email: 'user16@gmail.com', password: '12345678'},
    {email: 'user17@gmail.com', password: '12345678'},
    {email: 'user18@gmail.com', password: '12345678'},
    {email: 'user19@gmail.com', password: '12345678'},
    {email: 'user20@gmail.com', password: '12345678'}
  ])


question2 = Question.new(
    title: "jQueryについて質問です。",
    body: "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
)

question2.user = user
tag = Tag.create(name: 'jquery')
question2.tags << tag
tag2 = Tag.create(name: 'sqlite3')
question2.tags << tag2
question2.save!

20.times do |i|
  question2.views.find_or_create_by(user: users[i])
  vote = question2.votes.find_or_create_by!(user: users[i])
  vote.useful = true
  vote.save!
  answer = Answer.new(body: "回答します！#{i}")
  answer.question = question2
  answer.user = users[i]
  answer.save
end


question3 = Question.new(
    title: "VC++について質問です。",
    body: "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
)

question3.user = user
tag = Tag.create(name: 'c++')
question3.tags << tag
question3.save!

15.times do |i|
  question3.views.find_or_create_by(user: users[i])
  vote = question3.votes.find_or_create_by!(user: users[i])
  vote.useful = true
  vote.save!
  answer = Answer.new(body: "回答します！#{i}")
  answer.question = question3
  answer.user = users[i]
  answer.save
end


question4 = Question.new(
    title: "HTMLについて質問です。",
    body: "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
)

question4.user = user
tag = Tag.create(name: 'html')
question4.tags << tag
question4.tags << tag2
question4.save!

10.times do |i|
  question4.views.find_or_create_by(user: users[i])
  vote = question4.votes.find_or_create_by!(user: users[i])
  vote.useful = true
  vote.save!
  answer = Answer.new(body: "回答します！#{i}")
  answer.question = question4
  answer.user = users[i]
  answer.save
end

answer = Answer.new(body: "回答します！（正解）")
answer.question = question4
answer.marked = true
answer.user = user
answer.save
question4.solved = true
question4.save