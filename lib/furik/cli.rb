# frozen_string_literal: true

require_relative '../furik.rb'
require 'thor'

module Furik
  class Cli < Thor
    desc 'activity', 'show activity'
    method_option :since, type: :numeric, aliases: '-d', default: 0
    method_option :from, type: :string, aliases: '-f', default: Date.today.to_s
    method_option :to, type: :string, aliases: '-t', default: Date.today.to_s
    def activity
      from = Date.parse(options[:from])
      to   = Date.parse(options[:to])
      since = options[:since]

      diff = (to - from).to_i
      from -= since if diff.zero?
      puts '## GitHub Activities'
      puts ''

      Furik.events_with_grouping(from: from, to: to) do |repo, events|
        puts "### #{repo}"
        puts ''

        events.sort_by(&:type).reverse.each_with_object({ keys: [] }) do |event, memo|
          payload_type = event.type.gsub('Event', '').gsub(/.*Comment/, 'Comment').gsub('Issues', 'Issue').underscore
          payload = event.payload.send(:"#{payload_type}")
          type = payload_type.dup

          title = case event.type
                  when 'IssueCommentEvent'
                    "#{payload.body.plain.cut} (#{event.payload.issue.title})"
                  when 'CommitCommentEvent'
                    payload.body.plain.cut
                  when 'IssuesEvent'
                    type = "#{event.payload.action}_#{type}"
                    payload.title.plain
                  when 'PullRequestReviewCommentEvent'
                    type = 'comment'
                    if event.payload.pull_request.respond_to?(:title)
                      "#{payload.body.plain.cut} (#{event.payload.pull_request.title})"
                    else
                      payload.body.plain.cut
                    end
                  else
                    payload.title.plain
          end

          link = payload.html_url
          key = "#{type}-#{link}"

          next if memo[:keys].include?(key)

          memo[:keys] << key

          puts "- [#{type}](#{link}): #{title}"
        end

        Furik.reviews_by_repo(repo: repo, from: from, to: to) do |pulls|
          pulls.each do |pr_title, reviews|
            reviews.each { |r| puts "- [review](#{r.html_url}): #{pr_title} - #{r.state.downcase.gsub('_', ' ')}" }
          end
        end

        puts ''
      end
    end
  end
end
