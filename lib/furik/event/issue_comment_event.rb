# frozen_string_literal: true

module Furik
  module Event
    class IssueCommentEvent < GithubEvent
      PAYLOAD_TYPE = :comment

      def title
        "#{payload.body.plain.cut} (#{event.payload.issue.title})"
      end
    end
  end
end
