# frozen_string_literal: true
# Ruby optimization: makes all strings in this file immutable for better performance

require 'nokogiri'

module Jekyll
  module ResponsiveTables
    # Jekyll Liquid filter that adds data-label attributes to table cells.
    #
    # Usage in layouts:
    #   {{ content | responsive_tables }}
    #
    # @param content [String] HTML content containing tables
    # @return [String] HTML with data-label attributes added to table cells
    def responsive_tables(content)
      return content if content.nil? || content.empty?

      # Parse HTML into a document we can manipulate
      doc = Nokogiri::HTML::DocumentFragment.parse(content)
      
      # Process each table found in the content
      doc.css('table').each do |table|
        process_table(table)
      end

      # Return modified HTML as a string
      doc.to_html
    end

    private

    # Adds data-label attributes to all cells in a table
    # @param table [Nokogiri::XML::Element] The table element to process
    def process_table(table)
      # Extract header text from <th> elements to use as labels
      headers = table.css('thead th').map { |th| th.text.strip }
      return if headers.empty?

      # Add data-label to each cell matching its column header
      table.css('tbody tr').each do |row|
        row.css('td').each_with_index do |cell, index|
          # Only add if we have a header for this column
          cell['data-label'] = headers[index] if headers[index]
        end
      end
    end
  end
end

# Register this module as a Liquid filter so it can be used in templates
Liquid::Template.register_filter(Jekyll::ResponsiveTables)

