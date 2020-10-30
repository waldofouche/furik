# frozen_string_literal: true

module Furik
  module Event
    class PullRequestReviewEvent < GithubEvent
      def payload_type
        :review
      end

      def owner
        event.payload.pull_request
      end

      def title
        "#{event.payload.pull_request.title} (#{payload.state})"
      end

      def occurred_at
        payload.submitted_at
      end
    end
  end
end
