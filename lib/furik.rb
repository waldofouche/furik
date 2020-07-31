require 'octokit'
require 'furik/core_ext/string'
require 'furik/pull_requests'
require 'furik/events'
require "furik/version"

module Furik
  class << self
    def gh_client
      Octokit::Client.new(auto_paginate: true, per_page: 100, netrc: true)
    end

    def events_with_grouping(gh: true, from: nil, to: nil, &block)
      events = []

      if gh
        gh_events = Events.new(gh_client).events_with_grouping(from, to, &block)
        events.concat gh_events if gh_events.is_a?(Array)
      end

      events
    end

    def pull_requests(gh: true, &block)
      pulls = []

      if gh
        gh_pulls = PullRequests.new(gh_client).all(&block)
        pulls.concat gh_pulls if gh_pulls.is_a?(Array)
      end

      pulls
    end
  end
end
