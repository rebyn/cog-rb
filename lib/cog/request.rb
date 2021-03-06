
require 'json'

class Cog
  class Request
    attr_reader :options, :args, :input

    def initialize
      @args = populate_args
      @options = populate_options
      @input = JSON.parse(STDIN.read)
    end

    private

    def populate_args
      (0 .. (ENV['COG_ARGC'].to_i - 1)).map { |n| ENV["COG_ARGV_#{n}"] }
    end

    def populate_options
      return {} if ENV['COG_OPTS'].nil?

      options = ENV["COG_OPTS"].split(",")
      Hash[options.map { |opt| [ opt, ENV["COG_OPT_#{opt.upcase}"] ]}]
    end
  end
end
