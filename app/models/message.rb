class Message < ApplicationRecord
  validates :content, presence: true
  after_create_commit {MessageBroadcastJob.perform_later self}
  after_destroy_commit {MessageBroadcastJob.perform_later self.id}
end
