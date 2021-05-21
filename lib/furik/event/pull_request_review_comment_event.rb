# frozen_string_literal: true

module Furik
  module Event
    class PullRequestReviewCommentEvent < GithubEvent
      def payload_type
        :comment
      end

      def owner
        event.payload.pull_request
      end
    end
  end
end
