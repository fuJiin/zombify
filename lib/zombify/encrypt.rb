module Zombify

  class Encrypt

    def initialize(str)
      @string = str
      @aes    = FastAES.new(Zombify.key)
    end

    def generate
      repack @aes.encrypt(salted_repacked_str)
    end

    private

    def repack(str)
      Base64.encode64(str)
    end

    def repacked_str
      @repacked_str ||= repack(@string)
    end

    def salted_repacked_str
      Zombify.salt + repacked_str
    end
  end
end