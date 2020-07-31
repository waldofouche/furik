require 'test_helper'

class FurikTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Furik::VERSION
  end

  def test_gh_client_returns_octokit_client
    assert_equal Furik.gh_client.class, Octokit::Client
  end
end
