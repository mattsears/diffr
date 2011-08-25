require 'helper'

describe Diffr do

  describe "how do two strings diffr?" do

    it "should return an array diffs for single line strings" do
      Diffr.diffs("this is an old string", "this is a new string").must_equal [
        {:source=>:old, :line=>1, :change=>:delete, :string=>"this is an old string"},
        {:source=>:new, :line=>1, :change=>:add, :string=>"this is a new string"}
      ]
    end

    describe "with multiline strings" do
      before do
        @old_text = <<-END.gsub(/^ {6}/, '')
          This line of document stays the same.
          The dokument should be spelled correctly.
          This line should be deleted.
        END
        @new_text = <<-END.gsub(/^ {6}/, '')
          The new document has a line break!

          This line of document stays the same.
          The document should be spelled correctly.
          Finally, a brand new line.
        END
      end

      it "should return the diffs for each line" do
        Diffr.diffs(@old_text, @new_text).must_equal [
          {:source=>:new, :line=>1, :change=>:add, :string=>"The new document has a line break!"},
          {:source=>:new, :line=>2, :change=>:add, :string=>""},
          {:source=>:old, :line=>1, :change=>:same, :string=>"This line of document stays the same."},
          {:source=>:old, :line=>2, :change=>:delete, :string=>"The dokument should be spelled correctly."},
          {:source=>:old, :line=>3, :change=>:delete, :string=>"This line should be deleted."},
          {:source=>:new, :line=>4, :change=>:add, :string=>"The document should be spelled correctly."},
          {:source=>:new, :line=>5, :change=>:add, :string=>"Finally, a brand new line."}
        ]
      end
    end

  end
end
