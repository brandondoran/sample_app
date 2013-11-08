require 'spec_helper'

describe ApiKey do
  let(:token) { FactoryGirl.create(:api_key)}

  subject { token }

  it { should respond_to(:access_token) }
  
  it { should be_valid }
end
