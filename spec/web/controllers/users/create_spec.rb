RSpec.describe Web::Controllers::Users::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[user: {
    name: 'test',
    email: 'test@example.com',
    password: '12345678@password',
    password_confirmation: '12345678@password',
}] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
end
