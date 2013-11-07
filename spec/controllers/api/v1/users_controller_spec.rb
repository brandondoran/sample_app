require "spec_helper"

module Api
  module V1

		describe UsersController do
			render_views

			let(:user) { FactoryGirl.create(:user) }

			before do
		    sign_in user
		  end

			subject { model }

			context "JSON" do
				describe "index" do
					before do
						get :index, :format => :json
					end

					it 'should be valid' do
  					expect(response).to be_success
					end	

					it { expect(JSON.parse(response.body)['page_num']).to eq(1) }
					it { expect(JSON.parse(response.body)['total']).to eq(1) }
					it { expect(JSON.parse(response.body)['users'][0]['user']['id']).to eq(user.id) }
				end

				describe "show" do
					before do 
						get :show, :id => user, :format => :json
					end

					it 'should be valid' do
  					expect(response).to be_success
					end	

					it { expect(JSON.parse(response.body)['user']['id']).to eq(user.id) }
					it { expect(response).to be_success }
					it { expect(JSON.parse(response.body)['user']['id']).to eq(user.id) }
					it { expect(JSON.parse(response.body)['user']['email']).to eq(user.email) }
					it { expect(JSON.parse(response.body)['user']['followers_count']).to eq(user.followers.count) }
				end
			end
		end
	end
end
