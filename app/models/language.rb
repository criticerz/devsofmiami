class Language < ActiveRecord::Base
  has_many :profile_languages
  has_many :profiles, through: :profile_languages

  validates :name, :uniqueness => true

  scope :visible, -> { where('icon_class IS NOT NULL') }

  def self.update_all_slugs

    Language.update_all(:slug => nil)

    Language.all.each do |language|
      if Language.where(slug: language.name.parameterize).count == 0
        language.update_column(:slug, language.name.parameterize)
      else
        language.update_column(:slug, "#{language.name.parameterize}-#{Random.new.rand(1..9)}")
      end
    end
  end

end
