class EventLog < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :body, presence: true
  before_save :parse_ips

  private

  def parse_ips
    log = self.body.to_s
    src, dst = "", ""
    log.split(" ").each do |m|
      if m.include?("src")
        self.source_ip = m.split("=")[1]
      elsif m.include?("dst")
        self.dest_ip = m.split("=")[1]
      end
    end
  end
end
