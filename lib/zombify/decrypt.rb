module Zombify

  class Decrypt

    def initialize(pass)
      @pass = pass
      @aes  = FastAES.new(Zombify.key)
    end

    def solve
      depack(desalted_aes_decrypt)
    end

    private

    def depack(str)
      Base64.decode64(str)
    end

    def desalted_aes_decrypt
      @desalted_aes_decrypt ||= aes_decrypt.gsub(/\A#{Zombify.salt}/i, "")
    end

    def aes_decrypt
      @aes_decrypt ||= @aes.decrypt depack(@pass)
    end
  end
end