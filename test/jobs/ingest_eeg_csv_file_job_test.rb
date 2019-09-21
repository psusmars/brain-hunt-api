require 'test_helper'

class IngestEegCsvFileJobTest < ActiveJob::TestCase
  test "ingests a normal csv" do
    IngestEegCsvFileJob.perform_now('test/fixtures/files/haltest.txt')
    rs = ReadingSession.first
    assert rs
    assert_equal "haltest", rs.name
    assert_equal 9, BrainSample.count
    bs = BrainSample.first
    assert_equal rs, bs.reading_session
    assert_equal 91, bs.recorded_at.usec
    assert_equal 1567561661.0000908, bs.recorded_at.to_f
  end
end
