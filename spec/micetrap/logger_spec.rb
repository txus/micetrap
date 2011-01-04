require 'spec_helper'

module Micetrap

  describe Logger do

    describe "#initialize" do
      it 'initializes the filename' do
        Time.stub_chain('now.strftime')
            .and_return "2011-01-03__20-30"
        logger = Logger.new :ftp
        logger.filename.should == "micetrap_ftp_2011-01-03__20-30.log"
      end
    end

    describe "instance methods" do

      subject { Logger.new :ftp }

      describe "#file" do
        it 'returns the log file' do
          file = double('file')
          File.stub(:open).and_return file
          subject.file.should be(file)
        end
      end

      describe "#log" do
        it 'logs a scanned service along with the scanner info' do
          file = double('file')
          now = Time.now
          Time.stub(:now).and_return now
          File.stub(:open).and_return file

          expected_string = "\n#{time} FTP fake server recorded probes coming from hackerz.com:5978 containing the following:\n\t\t###EVILPROBE###"

          subject.file.should_receive(:write)
                      .with expected_string
                          
          subject.log "###EVILPROBE###", "hackerz.com", 5978
        end
      end
    end

  end
end
