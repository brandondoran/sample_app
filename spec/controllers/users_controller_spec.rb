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
						users_json = JSON.parse(response.body)
						pp users_json['users']
					end
					specify { expect(response).to be_success }
					specify { expect(users_json['page_num']).to eq(1) }
					specify { expect(users_json['total']).to eq(1) }
					#specify { expect(users_json['users']).to eq(1) }
				end

				describe "show" do
					before do 
						get :show, :id => user, :format => :json
						user_json = JSON.parse(response.body)
					end
					specify { expect(response).to be_success }
					specify { expect(users_json['user']['id']).to eq(user.id) }
					specify { expect(users_json['user']['email']).to eq(user.email) }
					specify { expect(users_json['user']['followers_count']).to eq(user.followers.count) }
				end
			end
		end
	end
end
