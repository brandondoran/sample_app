require "spec_helper"

module Api
  module V1

		describe UsersController do
			render_views

			let(:user) { FactoryGirl.create(:user) }
			let(:token) { FactoryGirl.create(:api_key)}

			before do
		    sign_in user
		  end

			subject { model }

			context "JSON" do
				describe "index" do
					# describe "unauthorized" do
					# 	before { get :index, :format => :json }
					# 	it { expect(response.status).to eq(401) }
					# end

					describe "authorized" do
						before do
							authorize_request(token)
							get :index, :format => :json
						end

						it 'should be valid' do
	  					expect(response).to be_success
						end	

						it { expect(json['page_num']).to eq(1) }
						it { expect(json['total']).to eq(1) }
						it { expect(json['users'][0]['user']['id']).to eq(user.id) }
					end
				end

				describe "show" do
					before do 
						authorize_request(token)
						get :show, :id => user, :format => :json
					end

					it 'should be valid' do
  					expect(response).to be_success
					end	

					it { expect(response).to be_success }
					it { expect(json['user']['id']).to eq(user.id) }
					it { expect(json['user']['email']).to eq(user.email) }
					it { expect(json['user']['followers_count']).to eq(user.followers.count) }
				end
			end
		end
	end
end
