desc 'Update comments counter cache for user'

task comment_counter: :environment do
  User.reset_column_information
  User.find_each do |u|
    User.reset_counters u.id, :comments
  end
end
