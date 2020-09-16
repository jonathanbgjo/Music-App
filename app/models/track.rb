class Track < ApplicationRecord
    validates :title, :ord, :album_id, presence: true

    belongs_to :album

    has_one :band,
        through: :album,
        source: :band

    has_many :notes,
        primary_key: :id,
        foreign_key: :track_id,
        class_name: :Note
end
