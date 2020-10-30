# frozen_string_literal: true

module Furik
  module Event
    class PullRequestEvent < GithubEvent
      def payload_type
        :pull_request
      end

      def type
        "#{event.payload.action} #{payload_type.to_s.gsub('_', ' ')}".capitalize
      end

      def summarize
        "- #{type}"
      end

      def occurred_at
        return payload.closed_at if event.payload.action == 'closed'

        payload.created_at
      end
    end
  end
end
