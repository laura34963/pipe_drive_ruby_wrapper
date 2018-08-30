RSpec.describe PipeDrive::Person do

  context '.host' do
    it 'should return host with setup organization name' do
      pipe_drive_host = "https://kdanmobile.pipedrive.com"
      expect(PipeDrive.host).to eq(pipe_drive_host)
    end
  end

  context '.requester' do
    it 'should setup requester with pipe drive host' do
      pipe_drive_host = "https://kdanmobile.pipedrive.com"
      expect(PipeDrive.requester.host).to eq(pipe_drive_host)
    end
  end
end