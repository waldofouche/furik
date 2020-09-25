# frozen_string_literal: true

module Furik
  module Event
    class PullRequestReviewEvent < GithubEvent
      def payload_type
        :review
      end

      def title
        "#{event.payload.pull_request.title} (#{payload.state})"
      end
    end
  end
end
