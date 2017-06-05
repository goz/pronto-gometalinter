require 'pronto'
require 'open3'
require 'shellwords'
require 'json'

module Pronto
  class Gometalinter < Runner
    def initialize(patches, commit = nil)
      super
      @executable = ENV['PRONTO_GOMETALINTER_EXECUTABLE'] || 'gometalinter'
    end

    def run
      return [] unless @patches

      @patches.select { |patch| valid_patch?(patch) }
        .map { |patch| inspect(patch) }
        .flatten.compact
    end

    def valid_patch?(patch)
      patch.additions > 0 && go_file?(patch.new_file_full_path)
    end

    def inspect(patch)
      escaped_executable = Shellwords.escape(@executable)
      escaped_path = Shellwords.escape(patch.new_file_full_path.to_s)

      Open3.popen3(`#{escaped_executable} #{escaped_path}`) do |stdout|
        while line = stdout.gets
          go_file_name, line_number, column_number, severity, message = line.split(':')
          Message.new(go_file_name, "#{line_number}:#{column_number}", severity, message, nil, self.class)
        end
      end
    end

    def go_file?(path)
      File.extname(path) == '.go'
    end
  end
end
