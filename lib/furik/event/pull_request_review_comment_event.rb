# frozen_string_literal: true

module Furik
  module Event
    class PullRequestReviewCommentEvent < GithubEvent
      PAYLOAD_TYPE = :comment

      def title
        return payload.body.plain.cut unless event.payload.pull_request.respond_to?(:title)

        "#{payload.body.plain.cut} (#{event.payload.pull_request.title})"
      end
    end
  end
end
