class EventLog < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :body, presence: true
  before_save :parse_ips

  def category(ip)
    octets = ip.split(".").map(&:to_i)
    case octets[0]
    when 10
      "Internal"
    when 172
      octets[1] >= 16 && octets[1] <= 31 ? "Internal" : "External"
    when 192
      octets[1] == 168 ? "Internal" : "External"
    else
      "External"
    end
  end

  def valid_state(ip)
    if ip.match?(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/)
      octects = ip.split(".").map(&:to_i)
      octects.any? {|oct| oct > 255} ? "Not valid" : "Valid"
    else
      "Not valid"
    end
  end

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
