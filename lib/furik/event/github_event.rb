# frozen_string_literal: true

module Furik
  module Event
    class GithubEvent
      attr_accessor :event, :payload

      def initialize(event)
        @event = event
        @payload = event.payload.send(PAYLOAD_TYPE)
      end

      def type
        PAYLOAD_TYPE.to_s
      end

      def key
        "#{type}-#{payload.html_url}"
      end

      def summarize
        "- [#{type}](#{payload.html_url}): #{title}"
      end

      def title
        event.payload.action
      end
    end
  end
end
