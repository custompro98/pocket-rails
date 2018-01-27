FactoryBot.define do
  factory :bookmark do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:url) { |n| "www.#{n}.com" }

    before(:create) do |bookmark|
      bookmark.user_id ||= create(:user).id
    end
  end
end
