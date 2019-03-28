RSpec.describe Web::Controllers::Books::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[book: {author: "James Baldwin", title: "The Fire Next Time"}] }
  let(:error_params) { Hash[book: {author: "", title: ""}] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 302
  end
  it 'is failed' do
    response = action.call(error_params)
    expect(response[0]).to eq 422
  end
end
