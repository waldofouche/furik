# frozen_string_literal: true

module Furik
  module Event
    class IssueCommentEvent < GithubEvent
      def payload_type
        :comment
      end

      def title
        "#{payload.body.plain.cut} (#{event.payload.issue.title})"
      end
    end
  end
end
