# frozen_string_literal: true

module Furik
  class Events
    def initialize(client)
      @client = client
      @login = client.login
    end

    def events_with_grouping(from, to, &block)
      events_by_repo = @client.user_events(@login).each.with_object({}) do |event, events|
        next unless valid_event?(event, from, to)

        events[event.repo.name] ||= []
        events[event.repo.name] << event
      end

      events_by_repo.each { |repo, events| block&.call(repo, events) }
    end

    private

    def valid_event?(event, from, to)
      event && types.include?(event.type) &&
        from <= event.created_at.localtime.to_date && event.created_at.localtime.to_date <= to
    end

    def types
      %w[
        IssuesEvent
        PullRequestEvent
        PullRequestReviewCommentEvent
        PullRequestReviewEvent
        IssueCommentEvent
        CommitCommentEvent
      ]
    end
  end
end
