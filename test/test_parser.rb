require 'parser'
require 'test_helper'

context "#Parser::Indentation - Flat File" do
  setup do
    @stdin = <<-EOF
this is a
very
flat file
    EOF

    obj = Sorted::Parser.new(@stdin)
  end

  asserts(:input).equals "this is a\nvery\nflat file\n"
end

#  asserts(:slug).equals "the-wizard-of-oz"
#  asserts(:summary).equals "Once upon a time&hellip;"
#  asserts(:url).equals "http://127.0.0.1/article_directory/the-wizard-of-oz/"
#  asserts(:path).equals "/article_directory/the-wizard-of-oz/"
#  asserts(:git_history).equals "https://github.com/gituser/gitrepo/commits/master/markdown/the-dichotomy-of-design.txt"
#  asserts(:git_source).equals "https://raw.github.com/gituser/gitrepo/master/markdown/the-dichotomy-of-design.txt"
#  asserts(:original).equals true
#  asserts(:tags).equals []
#  asserts(:categories).equals []
#  asserts(:comments).nil
#  asserts(:modified).equals "12/10/1932"
#  asserts(:source_name).nil
#  #asserts(:source_url).nil
#  asserts(:title).equals "the wizard of oz"
#  asserts(:date).equals "12/10/1932"
#  asserts(:author).equals ENV["USER"]
#  asserts(:summary).equals "Once upon a time&hellip;"
#
