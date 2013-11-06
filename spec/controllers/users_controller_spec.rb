require "spec_helper"

describe UsersController do
	render_views

	let(:api_user) { FactoryGirl.create(:user) }
	
	subject { model }

	context "JSON" do
		# describe "index" do
		# 	before { get :index, :format => :json }
		# 	it { response.response_code.should == 200 }
		# end

		describe "show" do
			before do 
				get :show, :id => api_user, :format => :json
				user_json = JSON.parse(response.body)
			end
			specify { expect(response).to be_success }
			specify { expect(JSON.parse(response.body)['user']['id']).to eq(api_user.id) }
			specify { expect(JSON.parse(response.body)['user']['email']).to eq(api_user.email) }
			specify { expect(JSON.parse(response.body)['user']['followers_count']).to eq(api_user.followers.count) }
			#specify { expect(response.body).should eql( {:user => api_user }.to_json) }
		end
	end
	
	# describe 'show' do
	# 	before { get "#{user_path(api_user)}.json"}
	# 	specify { expect(response).to be_success }
	# end

	# describe 'index' do
	# 	before do
	# 		get "/users.json", :format => :json
	# 		pp response
	# 	end
	# 	specify { expect(response).to be_success }
	# end
end