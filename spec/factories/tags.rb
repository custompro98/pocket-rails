FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Tag #{n}" }

    transient do
      taggable nil
    end

    before(:create) do |tag|
      tag.user_id ||= create(:user).id
    end

    after(:create) do |tag, evaluator|
      if evaluator.taggable.present?
        taggable = evaluator.taggable
        create(:tag_join, tag_id: tag.id,
                          taggable_id: taggable.id,
                          taggable_type: taggable.class.name)
      end
    end
  end
end
