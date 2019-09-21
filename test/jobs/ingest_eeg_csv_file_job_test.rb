require 'test_helper'

class IngestEegCsvFileJobTest < ActiveJob::TestCase
  test "ingests a normal csv" do
    IngestEegCsvFileJob.perform_now('OpenBCI-RAW-2.3.1.c3.hal.txt')
  end
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
end
