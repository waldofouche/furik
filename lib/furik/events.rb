# frozen_string_literal: true

module Furik
  class Events
    def initialize(client)
      require_types.each { |t| require_relative "event/#{t}.rb" }
      @client = client
      @login = client.login
    end

    def events_with_grouping(from, to, &block)
      events_by_repo = @client.user_events(@login).each.with_object({}) do |event, events|
        next unless valid_event?(event, from, to)

        github_event = %W[Furik Event #{event.type}].inject(Object) { |o, c| o.const_get c }.new(event)
        events[event.repo.name] ||= {}
        (events[event.repo.name][github_event.owner_as_string] ||= []) << github_event.type
      end

      events_by_repo.each { |repo, events| block&.call(repo, events) }
    end

    private

    def valid_event?(event, from, to)
      types.include?(event.type) &&
        from <= event.created_at.localtime.to_date &&
        event.created_at.localtime.to_date <= to
    end

    def types
      %w[IssuesEvent
         PullRequestEvent
         PullRequestReviewCommentEvent
         PullRequestReviewEvent
         IssueCommentEvent]
    end

    def require_types
      types.map do |type|
        type.to_s
            .gsub(/::/, '/')
            .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .tr('-', '_')
            .downcase
      end.prepend('github_event')
    end
  end
end
