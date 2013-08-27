require "fast-aes"
require "base64"

module Zombify

  class NotConfigured < StandardError

    def initialize(missing)
      @missing = missing
    end

    def message
      "Please specify Zombify.#{@missing} in configuration"
    end
  end

  class << self

    def load_path
      File.dirname(__FILE__)
    end

    def key
      @key || raise(NotConfigured.new "key")
    end

    def key=(str)
      @key = str
    end

    def salt
      @salt || raise(NotConfigured.new "salt")
    end

    def salt=(str)
      @salt = str
    end

    def configure(&block)
      yield(self)
    end

    def encrypt(str)
      Encrypt.new(str).generate
    end

    def decrypt(str)
      Decrypt.new(str).solve
    end
  end

  autoload :Encrypt, "#{load_path}/zombify/encrypt"
  autoload :Decrypt, "#{load_path}/zombify/decrypt"

  autoload :Data, "#{load_path}/zombify/data"
end