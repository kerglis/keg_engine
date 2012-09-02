require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'
#require 'rails/generators/erb/scaffold/scaffold_generator'

module Rails
  module Generators
    class KegResourceGenerator < ScaffoldControllerGenerator
      source_root File.expand_path("../templates", __FILE__)

      #source_root File.expand_path("../templates", __FILE__)
      # def self.source_root
      #   binding.pry

      #   @source_root ||= File.expand_path("templates", File.dirname(__FILE__))
      # end
    end
  end
end