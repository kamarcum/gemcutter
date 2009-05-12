require 'rubygems/command_manager'

class Gem::Commands::PushCommand < Gem::Command
  def description
    "Pushes your gem up to gemcutter"
  end

  def arguments
    "GEM       built gem to push up"
  end

  def usage
    "#{programe_name} GEM"
  end

  def initialize
    super 'push', 'Push a gem up to Gemcutter'
  end

  def execute
    require 'restclient'
    say "Pushing gem to Gemcutter..."

    path = get_one_gem_name
    RestClient.post "http://gemcutter.org/gems", File.open(path)
  end
end

Gem::CommandManager.instance.register_command :push