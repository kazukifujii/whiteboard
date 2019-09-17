class StickyNote < ApplicationRecord
  validates :content, presence: true

  after_create_commit {StickyNoteBroadcastJob.perform_later self}
  after_destroy_commit {StickyNoteBroadcastJob.perform_later self.id}
end
