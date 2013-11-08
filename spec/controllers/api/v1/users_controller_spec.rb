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
					describe "without auth token" do
						before { get :index, :format => :json }
						it { expect(response.status).to eq(401)}
					end

					describe "with auth token" do
						let!(:all) { 30.times { FactoryGirl.create(:user) } }
						before do
							authorize_request(token)
							get :index, :format => :json
						end
						
						it 'should be valid' do
	  					expect(response).to be_success
						end	

						it { expect(json['page_num']).to eq(1) }
						it { expect(json['total']).to eq(31) }
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

					describe "with friends and followers" do
						let(:friend) { FactoryGirl.create(:user)}
						let(:follower) {FactoryGirl.create(:user)}

						before do
							follower.follow!(user)
							user.follow!(friend)

							authorize_request(token)
							get :show, :id => user, :format => :json
						end

						it 'should return user with friends and followers' do
							expect(json['user']['id']).to eq(user.id)
							expect(json['user']['email']).to eq(user.email)
							expect(json['user']['followers_count']).to eq(user.followers.count)
							expect(json['user']['followed_users_count']).to eq(user.followed_users.count)
							expect(json['user']['followed_users'][0]['followed_user']['id']).to eq(friend.id)
							expect(json['user']['followers'][0]['follower']['id']).to eq(follower.id)
						end
					end
				end
			end
		end
	end
end

