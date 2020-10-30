# frozen_string_literal: true

module Furik
  module Event
    class PullRequestReviewCommentEvent < GithubEvent
      def payload_type
        :comment
      end

      def summarize
        "- [##{event.payload.pull_request.number}] #{title}"
      end

      def title
        return payload.body.plain.cut unless event.payload.pull_request.respond_to?(:title)

        "#{payload.body.plain.cut} (#{event.payload.pull_request.title})"
      end
    end
  end
end
