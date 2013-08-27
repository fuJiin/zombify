require "json"

module Zombify

  class Data

    def self.generate(data = {})
      data = data.merge("timestamp" => Time.now.to_i)
      Zombify.encrypt(data.to_json)
    end

    def initialize(raw)
      @raw = raw
    end

    def decrypted
      @decrypted ||= JSON.parse Zombify.decrypt(@raw)
    end

    def timestamp
      decrypted["timestamp"]
    end

    def valid?
      (Time.now.to_i - timestamp.to_i) > Zombify.expires
    end
  end
end