RSpec.describe PipeDrive::Person do

  context '.resource_name' do
    it 'should return resource name' do
      expect(PipeDrive::Person.resource_name).to eq('person')
    end
  end

  context '.custom_field_keys' do
    it 'should obtain person custom field' do
      person_custom_fields = {role: 'sljgiashigowiojeasdgh'}
      expect(PipeDrive::Person.custom_field_keys).to eq(person_custom_fields)
    end
  end
end