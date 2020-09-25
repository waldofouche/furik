# frozen_string_literal: true

module Furik
  module Event
    class PullRequestReviewComment < GithubEvent
      PAYLOAD_TYPE = :review

      def title
        "#{event.payload.pull_request.title} (#{payload.state})"
      end
    end
  end
end
