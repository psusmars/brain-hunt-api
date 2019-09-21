require 'test_helper'

class IngestEegCsvFileJobTest < ActiveJob::TestCase
  test "ingests a normal csv" do
    IngestEegCsvFileJob.perform_now('test/fixtures/files/haltest.txt')
    rs = ReadingSession.first
    assert rs
    assert_equal "haltest", rs.name
    assert_in_delta 200, rs.sample_rate, 0.1
    assert_equal 4, rs.number_of_channels, 4
    assert_equal 9, BrainSample.count
    bs = BrainSample.first
    assert_equal rs, bs.reading_session
    assert_equal 91000, bs.recorded_at.usec, "Should be 91000 microseconds, aka 91 milliseconds"
    assert_equal 1567561661.0000908, bs.recorded_at.to_f
  end

  test "raises an error if no channels specified" do
    assert_raises IngestEegCsvFileJob::InvalidCSVDataError do
      IngestEegCsvFileJob.perform_now('test/fixtures/files/haltestbad.txt')
    end
  end
end
