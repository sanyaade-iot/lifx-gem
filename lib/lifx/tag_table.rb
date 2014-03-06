module LIFX
  class TagTable
    class Entry < Struct.new(:tag_id, :label, :site_id); end

    def initialize
      @entries = Hash.new { |h, k| h[k] = {} }
    end

    def entries_with(tag_id: nil, site_id: nil, label: nil)
      @entries.values.map(&:values).flatten.select do |entry|
        ret = []
        ret << (entry.tag_id == tag_id) if tag_id
        ret << (entry.site_id == site_id) if site_id
        ret << (entry.label == label) if label
        ret.all?
      end
    end

    def entry_with(**args)
      entries_with(**args).first
    end

    def update_table(tag_id:, label:, site_id:)
      entry = @entries[site_id][tag_id] ||= Entry.new(tag_id, label, site_id)
      entry.label = label
    end

    def tags
      @entries.values.map(&:values).flatten.map(&:label).uniq
    end
  end
end
