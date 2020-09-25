# frozen_string_literal: true

module Furik
  module Event
    class GithubEvent
      attr_accessor :event, :payload

      def initialize(event)
        @event = event
        @payload = event.payload.send(payload_type)
      end

      def type
        payload_type.to_s.gsub('_', ' ').capitalize
      end

      def key
        "#{type}-#{payload.html_url}"
      end

      def summarize
        "- [#{type}](#{payload.html_url}): #{title}"
      end

      def title
        payload.title.plain
      end
    end
  end
end
