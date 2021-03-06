10.times { User.create!( username: Faker::Internet.user_name, email: Faker::Internet.email, password:"password" )}

users = User.all

#Make Questions:
users.each do |user|
  2.times { user.questions.create!( title: Faker::Book.title, content: Faker::Lorem.paragraph(2) ) }
end

#Make Answers
users.each do |user|
  counter = 1
  20.times do
    user.answers.create!( content: Faker::Lorem.sentence, question_id: counter)
    counter += 1
  end
end

#Make Best Answers
users.each do |user|
  user.questions.each do |question|
    q_answers = question.answers
    question.best_answer_id = q_answers.sample.id
    question.save
  end
end

#Make Comments on Questions

users.each do |user|
  user.questions.each do |question|
      5.times { question.responses.create!(content: Faker::Lorem.sentence, responder_id: (rand(10) + 1) ) }
  end
end

#Make Comments on Answers

users.each do |user|
  user.answers.each do |answer|
      5.times { answer.responses.create!(content: Faker::Lorem.sentence, responder_id: (rand(10) + 1) ) }
  end
end

#Make Votes on Questions

users.each do |user|
vote_counter = 10
  user.questions.each do |question|
    question.votes.create!( value: rand(10)+1, voter_id: vote_counter)
    vote_counter -= 1
  end
end

#Make Votes on Answers

users.each do |user|
vote_counter = 10
  user.answers.each do |answer|
    answer.votes.create!( value: rand(10)+1, voter_id: vote_counter)
    vote_counter -= 1
  end
end

#Make tags for Questions
questions = Question.all

questions.each do |question|
  num = rand(3) + 1

  num.times do
    new_tag = Tag.new(name: Faker::Commerce.department(1, true))
    old_tag = Tag.find_by(name: new_tag.name)
    if old_tag
    question.tags.push(old_tag)
    else
      question.tags.create!(name: new_tag.name)
    end
  end
end

Question.all.each do |q|
  q.count_votes
  q.save
end