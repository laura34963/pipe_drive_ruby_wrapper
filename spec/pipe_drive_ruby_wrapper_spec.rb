RSpec.describe PipeDrive do
  context '.setup' do
    it 'should setup basic info for pipedrive' do
      PipeDrive.setup do |config|
        config.api_token = 'api token'
        config.field_keys = {
          person: {test: {id: 1, key: 'test_key'}}
        }
        config.stage_ids = {
          1 => {
            test: 1
          }
        }
      end
      expect(PipeDrive.api_token).to eq('api token')
      expect(PipeDrive.field_keys).to eq({person: {test: {id: 1, key: 'test_key'}}})
      expect(PipeDrive.stage_ids).to eq({1 => {test: 1}})
    end
  end

  context '.host' do
    it 'should return host with setup organization name' do
      pipe_drive_host = "https://api.pipedrive.com"
      expect(PipeDrive.host).to eq(pipe_drive_host)
    end
  end

  context '.requester' do
    it 'should setup requester with pipe drive host' do
      pipe_drive_host = "https://api.pipedrive.com"
      expect(PipeDrive.requester.host).to eq(pipe_drive_host)
    end
  end
end