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
    end
  end
end
