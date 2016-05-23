
require 'json'

class Cog
  class Command
    attr_writer :memory_key, :config

    def request
      @request ||= Cog::Request.new
    end

    def response
      @response ||= Cog::Response.new
    end

    def memory_key
      @memory_key ||= ENV['COG_INVOCATION_ID']
    end

    def config
      @config ||= { input: @@input }
    end

    def step
      ENV['COG_INVOCATION_STEP'].to_sym
    end

    def accumulate_input
      Cog::Services::Memory.accum(memory_key, request.input)
    end

    def fetch_input
      Cog::Services::Memory.get(memory_key)
    end

    def execute
      accumulate_input if config[:input] == :accumulate
      run_command
      response.send
    end

    def self.input(value)
      @@input = value
    end
  end
end