RSpec.describe PipeDrive::Organization do

  context '.resource_name' do
    it 'should return resource name' do
      expect(PipeDrive::Organization.resource_name).to eq('organization')
    end
  end

  context '.field_keys' do
    it 'should obtain person custom field' do
      org_custom_fields = {region: 'rguwjiownuibnejaoijfon'}
      expect(PipeDrive::Organization.field_keys).to eq(org_custom_fields)
    end
  end
end