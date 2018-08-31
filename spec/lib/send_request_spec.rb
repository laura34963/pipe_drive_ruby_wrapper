RSpec.describe PipeDrive::SendRequest do

  context '.initialize' do
    it 'should raise missing api token error if not set api token' do
      PipeDrive.api_token = nil
      expect{PipeDrive::SendRequest.new}.to raise_error(PipeDrive::MissingApiToken)
    end
  end
  
end