require 'ostruct'

module IDEA
  class Command
    def self.run(inputs)
      self.new.run(inputs)
    end

    def failure(error_sym, data={})
      CommandFailure.new(data.merge :error =>error_sym)
    end

    def success(data={})
      CommandSuccess.new(data)
    end
  end

  # class Command < OpenStruct
  #   def success?
  #     false
  #   end
  #   def error?
  #     true
  #   end
  # end

  class CommandSuccess < OpenStruct
    def success?
      true
    end
    def error?
      false
    end
  end
end
