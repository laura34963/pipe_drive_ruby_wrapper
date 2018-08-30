RSpec.describe PipeDrive::Deal do

  context '.resource_name' do
    it 'should return resource name' do
      expect(PipeDrive::Deal.resource_name).to eq('deal')
    end
  end

  context '.field_keys' do
    it 'should obtain person custom field' do
      deal_custom_fields = {product: 'aksjghisauhgkjsdkgnjk'}
      expect(PipeDrive::Deal.field_keys).to eq(deal_custom_fields)
    end
  end
end