# encoding: utf-8

require_relative '../app/models/cli'

describe Cli do

  it 'sanitizes user input' do
    Cli.stub!(:gets) { "DingDöng!\n" }
    Cli.get_input
  end

end