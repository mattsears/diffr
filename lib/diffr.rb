require "diffr/version"
#
# == Diffr Module
#
# A simple utility that returns the differences between two strings
#
# == Examples:
#
#   @old = "This line of document stays the same.
#   The dokument should be spelled correctly.
#   This line should be deleted."
#
#   @new = "The new document has a line break!
#
#   This line of document stays the same.
#   The document should be spelled correctly.
#   Finally, a brand new line."
#
#   Diff.diffs(old, new)
#
#  Produces:
#  [ {:source=>:new, :line=>1, :change=>:add, :string=>"The new document has a line break!"},
#    {:source=>:new, :line=>2, :change=>:add, :string=>""},
#    {:source=>:old, :line=>1, :change=>:same, :string=>"This line of document stays the same."},
#    {:source=>:old, :line=>2, :change=>:delete, :string=>"The dokument should be spelled correctly."},
#    {:source=>:old, :line=>3, :change=>:delete, :string=>"This line should be deleted."},
#    {:source=>:new, :line=>4, :change=>:add, :string=>"The document should be spelled correctly."},
#    {:source=>:new, :line=>5, :change=>:add, :string=>"Finally, a brand new line."} ]
#
module Diffr
  attr_accessor :diffs, :sequences

  # Returns an array of hashes that contain metadata about the differences
  # between the two given strings.
  #
  # @return [Array] of diffs
  #
  def self.diffs(old, new)
    new, old, @diffs = new.lines.to_a, old.lines.to_a, []
    build_sequences(old, new)
    find_diffs(old, new, old.size, new.size)
  end

  private

  # Backtrace through the sequences and determine what changed between the old
  # string and new string
  #
  # @return [Array] of diffs
  #
  def self.find_diffs(old, new, row, col)
    if row > 0 && col > 0 && old[row-1] == new[col-1]
      find_diffs(old, new, row-1, col-1)
      @diffs << { :source => :old, :line => row, :change => :same, :string => old[row-1].strip }
    elsif col > 0 && (row == 0 || @sequences[row][col-1] >= @sequences[row-1][col])
      find_diffs(old, new, row, col-1)
      @diffs << { :source => :new, :line => col, :change => :add, :string => new[col-1].strip }
    elsif row > 0 && (col == 0 || @sequences[row][col-1] < @sequences[row-1][col])
      find_diffs(old, new, row-1, col)
      @diffs << { :source => :old, :line => row, :change => :delete, :string => old[row-1].strip }
    end
  end

  # Build a sequence matrix by finding the sequence of items that is present in
  # both original string in the same order. That is, find a new sequence which
  # can be obtained from the first sequence by deleting some items, and from the
  # second sequence by deleting other items.
  #
  # @return [Array] of sequences
  #
  def self.build_sequences(old, new)
    rows, cols = old.size+1, new.size+1
    @sequences = rows.times.map{|x|[0]*(x+1)}
    rows.times.each do |row|
      cols.times.each do |col|
        @sequences[row][col] = if old[row-1] == new[col-1]
          @sequences[row-1][col-1] + 1
        else
          [@sequences[row][col-1].to_i, @sequences[row-1][col].to_i].max
        end
      end
    end
  end

end
