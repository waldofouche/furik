# frozen_string_literal: true

module Furik
  module Event
    class IssueCommentEvent < GithubEvent
      def payload_type
        :comment
      end

      def summarize
        "- [##{event.payload.issue.number}](#{payload.html_url}): #{payload.body.plain.cut}"
      end
    end
  end
end
