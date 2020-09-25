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

      def summarize
        "- [##{event.payload.pull_request.number}](#{payload.html_url}): #{title}"
      end
    end
  end
end
